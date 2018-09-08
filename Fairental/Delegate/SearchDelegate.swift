//
//  SearchDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class SearchDelegate: Networkable {
    
    let endpoint = "https://api.sandbox.amadeus.com/v1.2/cars/search-circle"
    
    private var requestData: SearchRequest!
    
    init(_ model: SearchViewModel) {
        requestData = SearchRequest(
            latitude: 35.1504,
            longitude: -114.57632,
            radius: 42,
            pickUp: TimelessDate(string: "2018-12-07")!,
            dropOff: TimelessDate(string: "2018-12-08")!)
    }
    
    func execute() {
        post("searchExecute")
        guard let urlComponents = URLComponents(string: endpoint) else {
            error()
            return
        }
        var components = urlComponents
        components.queryItems = parameterize2(requestData)
        
        //urlComponents.queryItems = parameterize2(requestData)
        
        var request = URLRequest(url: components.url!)
        
        print(request.httpMethod)
        
        let foo = parameterize(requestData)
        print(foo)
        
        //request.quer
        request.allHTTPHeaderFields = parameterize(foo)
        
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request, completionHandler: response).resume()
    }
    
    func response(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let rawResponse = String(data: data, encoding: .utf8) else {
            self.error()
            return
        }
        print(rawResponse)
        post("searchResponse")
    }
    
    func error() {
        post("searchError")
    }
    
}
