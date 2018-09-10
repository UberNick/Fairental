//
//  SearchViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchViewController: UIViewController, Listenable, AlertPresentable {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var pickupButton: UIButton!
    @IBOutlet weak var dropoffButton: UIButton!
    
    @IBOutlet weak var dateToolbar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var gradientBackpanel: UIView!
    
    var dateButtonEdited: UIButton?
    
    var viewModel = SearchViewModel()
    var locationManager = CLLocationManager()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideDatePicker()
        
        // initialize other tabs so their notification listeners are active
        tabBarController?.viewControllers?.forEach { viewController in
            let _ = viewController.view
            let _ = (viewController as? UINavigationController)?.viewControllers.first?.view
        }
        
        // set up location
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.requestLocation()
        }
        
        // listen for service delegate notifications
        listen(ReverseGeocodeDelegate.Notification.execute.rawValue, #selector(addressWillLoad))
        listen(ReverseGeocodeDelegate.Notification.response.rawValue, #selector(addressDidLoad))
        listen(ReverseGeocodeDelegate.Notification.error.rawValue, #selector(addressDidLoad))
        
        listen(GeocodeDelegate.Notification.response.rawValue, #selector(locationDidLoad))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchField.text = viewModel.address
        pickupButton.setTitle(viewModel.displayPickup, for: .normal)
        dropoffButton.setTitle(viewModel.displayDropoff, for: .normal)
    }
    
    override func viewWillLayoutSubviews() {
        gradientBackpanel.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        let layer = gradientLayer(rect: gradientBackpanel.bounds, colors: [
            UIColor.white.withAlphaComponent(0.5),
            UIColor.white.withAlphaComponent(1.0)])
        gradientBackpanel.layer.addSublayer(layer)
    }
    
    //MARK: - Notification Handlers
    @objc func locationDidLoad(notification: Notification) {
        guard let placemark = notification.object as? CLPlacemark,
            let location = placemark.location else {
            return
        }
        viewModel.location = Location(latitude: location.coordinate.latitude,
                                      longitude: location.coordinate.longitude)
    }
    
    @objc func addressWillLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    @objc func addressDidLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
        guard let placemark = notification.object as? CLPlacemark else {
            return
        }
        viewModel.address = placemark.postalCode ?? ""
        searchField.text = viewModel.address
    }
    
    //MARK: - IBActions
    @IBAction func dateButtonTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        dateButtonEdited = button
        showDatePicker(animated: true)
        if dateButtonEdited === pickupButton {
            datePicker.date = viewModel.pickup
        } else if dateButtonEdited === dropoffButton {
            datePicker.date = viewModel.dropoff
        } else {
            datePicker.date = Date()
        }
    }
    
    @IBAction func locationTapped(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        hideAllInputControls()
    }
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        hideDatePicker()
    }
    
    @IBAction func searchFieldEdited(_ sender: Any) {
        viewModel.address = searchField.text ?? ""
        GeocodeDelegate(viewModel.address).execute()
    }
    
    @IBAction func searchFieldAction(_ sender: Any) {
        searchTapped(sender)
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        hideAllInputControls()
        guard let searchDelegate = SearchDelegate(viewModel) else {
            presentAlert("Please select a location.")
            return
        }
        // open results page
        (parent as? UITabBarController)?.selectedIndex = 1
        searchDelegate.execute()
    }
    
    @IBAction func dateDoneTapped(_ sender: Any) {
        hideDatePicker(animated: true)
        
        if dateButtonEdited === pickupButton {
            viewModel.pickup = datePicker.date
            pickupButton.setTitle(viewModel.displayPickup, for: .normal)
        } else if dateButtonEdited === dropoffButton {
            viewModel.dropoff = datePicker.date
            dropoffButton.setTitle(viewModel.displayDropoff, for: .normal)
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        hideAllInputControls()
    }
    
    //MARK: - Helper and Hide/Show Functions
    func gradientLayer(rect: CGRect, colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = rect
        layer.colors = colors.map { $0.cgColor }
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 0, y: 0)
        return layer
    }
    
    func showDatePicker(animated: Bool = false) {
        hideKeyboard()
        datePicker.isHidden = false
        dateToolbar.isHidden = false
    }
    
    func hideDatePicker(animated: Bool = false) {
        datePicker.isHidden = true
        dateToolbar.isHidden = true
    }
    
    func hideKeyboard() {
        searchField.resignFirstResponder()
    }
    
    func hideAllInputControls(animated: Bool = false) {
        hideDatePicker(animated: animated)
        hideKeyboard()
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
        case .restricted, .denied: break
        case .authorizedWhenInUse, .authorizedAlways: break
        case .notDetermined: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        viewModel.location = Location(latitude: location.coordinate.latitude,
                                      longitude: location.coordinate.longitude)
        ReverseGeocodeDelegate(location).execute()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
