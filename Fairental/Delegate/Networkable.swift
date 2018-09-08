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
    
    func parameterize<T: Encodable>(_ data: T) -> [String: String] {
        guard let json = try? encoder.encode(data),
            let jsonObject = try? JSONSerialization.jsonObject(with: json),
            let dataDict = jsonObject as? [String: Any] else {
                return [:]
        }
        var params: [String: String] = ["apikey": apiKey]
        dataDict.forEach { key, value in
            params[key] = "\(value)"
        }
        return params
    }
    
    func parameterize2<T: Encodable>(_ data: T) -> [URLQueryItem] {
        guard let json = try? encoder.encode(data),
            let jsonObject = try? JSONSerialization.jsonObject(with: json),
            let dataDict = jsonObject as? [String: Any] else {
                return []
        }
        var params: [String: String] = ["apikey": apiKey]
        var items: [URLQueryItem] = [URLQueryItem(name: "apikey", value: apiKey)]
        dataDict.forEach { key, value in
            params[key] = "\(value)"
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        return items
    }
    
}
