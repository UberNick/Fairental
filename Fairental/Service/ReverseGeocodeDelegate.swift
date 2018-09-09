//
//  ReverseGeocodeDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import CoreLocation

class ReverseGeocodeDelegate: NSObject, CLLocationManagerDelegate, Notifiable {
    
    var location: CLLocation!
    
    enum Notification: String {
        case execute = "ReverseGeocodeDelegate.execute"
        case response = "ReverseGeocodeDelegate.response"
        case error = "ReverseGeocodeDelegate.error"
    }
    
    init(_ location: CLLocation) {
        self.location = location
    }
    
    func execute() {
        post(Notification.execute.rawValue)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: response)
    }
    
    func response(placemarks: [CLPlacemark]?, error: Error?) {
        guard let placemark = placemarks?.first else {
            post(Notification.error.rawValue)
            return
        }
        post(Notification.response.rawValue, placemark)
    }
}
