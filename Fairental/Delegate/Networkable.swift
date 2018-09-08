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
    
    func post(_ notification: String, _ payload: Any? = nil) {
        let notificationName = Notification.Name(notification)
        NotificationCenter.default.post(name: notificationName, object: payload)
    }
    
    func parameterize<T: Encodable>(_ data: T) -> [URLQueryItem] {
        guard let json = try? encoder.encode(data),
            let jsonObject = try? JSONSerialization.jsonObject(with: json),
            let dataDict = jsonObject as? [String: Any] else {
                return []
        }
        var params: [URLQueryItem] = [URLQueryItem(name: "apikey", value: apiKey)]
        dataDict.forEach { key, value in
            params.append(URLQueryItem(name: key, value: "\(value)"))
        }
        return params
    }
    
}
