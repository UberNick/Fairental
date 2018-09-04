//
//  Networkable.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

protocol Networkable {
    func execute()
    func response(data: Data?, response: URLResponse?, error: Error?)
}

extension Networkable {
    var apiKey: String {
        return "yz8HeOAXRrxuToDKRYWYGiLo9K6S73pH"
    }
    
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    func post(_ notification: String) {
        let notificationName = Notification.Name(notification)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    //func toParams(json: )
}
