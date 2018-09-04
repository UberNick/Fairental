//
//  SearchDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class SearchDelegate {
    
    let endpoint = "https://api.sandbox.amadeus.com/v1.2/cars/search-circle"
    let apiKey = "yz8HeOAXRrxuToDKRYWYGiLo9K6S73pH"
    
    private var requestData: SearchRequest!
    private var dataTask: URLSessionDataTask?
    
    var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    init(_ model: SearchViewModel) {
        requestData = SearchRequest(
            latitude: "35.1504",
            longitude: "-114.57632",
            radius: "42",
            pickUp: "2018-12-07",
            dropOff: "2018-12-08")
    }
    
    func execute() {
        let notification = Notification.Name("searchExecute")
        NotificationCenter.default.post(name: notification, object: nil)
        
        guard let url = URL(string: endpoint),
            let json = try? encoder.encode(requestData),
            let requestDataDict  = try? JSONSerialization.jsonObject(with: json) else {
                fault()
                return
        }
        
        var params: [String: String] = ["apikey": apiKey]
        
        print("FOO:")
        print(requestDataDict)
        print("BAR:")
        print(requestDataDict as? [String: String])
        
        /*requestDataDict.forEach { key, value in
            params[key] = value as? String
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = params*/
        
        
        
        
    }
    
    func result() {
        let notification = Notification.Name("searchResult")
        NotificationCenter.default.post(name: notification, object: nil)
    }
    
    func fault() {
        let notification = Notification.Name("searchFault")
        NotificationCenter.default.post(name: notification, object: nil)
    }
    
}

/*
 override func workItem() {
 let endpoint = "/mobileadapterstatus"
 

 
 let request = URLRequest(url: url)
 
 #if DEBUG
 let networkOperationSelf = self as NetworkOperation
 OperationCache.setRequest(networkOperationSelf, value: debugDescription(request))
 #endif
 
 dataTask = createURLSession().dataTask(with: request, completionHandler: response)
 dataTask?.resume()
 }*/
