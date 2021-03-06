//
//  DirectionViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit
import MapKit

class DirectionViewController: UIViewController, Listenable {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        listen(DirectionDelegate.Notification.execute.rawValue, #selector(directionsWillLoad))
        listen(DirectionDelegate.Notification.response.rawValue, #selector(directionsDidLoad))
    }
    
    // MARK: - Notification Handlers
    @objc func directionsWillLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    @objc func directionsDidLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
        guard let routes = notification.object as? [MKRoute] else {
           return
        }
        routes.forEach { route in
            mapView.add(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
}

extension DirectionViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: MKPolyline(points: [], count: 0))
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = .blue
        return renderer
    }
}
