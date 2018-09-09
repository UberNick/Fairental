//
//  GeocodeDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import CoreLocation

class GeocodeDelegate: NSObject, CLLocationManagerDelegate, Notifiable {

    var address: String!
    
    enum Notification: String {
        case execute = "GeocodeDelegate.execute"
        case response = "GeocodeDelegate.response"
        case error = "GeocodeDelegate.error"
    }
    
    init(_ address: String) {
        self.address = address
    }
    
    func execute() {
        post(Notification.execute.rawValue)
        CLGeocoder().geocodeAddressString(address, completionHandler: response)
    }
    
    func response(placemarks: [CLPlacemark]?, error: Error?) {
        guard let placemark = placemarks?.first else {
            post(Notification.error.rawValue)
            return
        }
        post(Notification.response.rawValue, placemark)
    }
}
