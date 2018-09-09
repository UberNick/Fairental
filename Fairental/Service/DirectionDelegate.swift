//
//  DirectionDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import CoreLocation
import MapKit

class DirectionDelegate: Notifiable {
    
    var from: Location!
    var to: Location!
    
    enum Notification: String {
        case execute = "DirectionDelegate.execute"
        case response = "DirectionDelegate.response"
        case error = "DirectionDelegate.error"
    }
    
    required init?(_ viewModel: DetailViewModel) {
        guard let from = viewModel.userLocation,
            let to = viewModel.carLocation else {
            return nil
        }
        self.from = from
        self.to = to
    }
    
    func execute() {
        post(Notification.execute.rawValue)

        let request = MKDirectionsRequest()
        request.source = mapItem(from)
        request.destination = mapItem(to)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: response)
    }
    
    func response(response: MKDirectionsResponse?, error: Error?) {
        guard let routes = response?.routes else {
            post(Notification.error.rawValue)
            return
        }
        // send [MKRoute]
        post(Notification.response.rawValue, routes)
    }
    
    func mapItem(_ location: Location) -> MKMapItem {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                longitude: location.longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        return MKMapItem(placemark: placemark)
    }
}
