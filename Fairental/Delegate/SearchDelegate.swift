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
            pickUp: "2018-12-07",
            dropOff: "2018-12-08")
    }
    
    func execute() {
        post("searchExecute")
        guard let url = URL(string: endpoint) else {
            error()
            return
        }        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = parameterize(requestData)
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request, completionHandler: response).resume()
    }
    
    func response(data: Data?, response: URLResponse?, error: Error?) {
        post("searchResponse")
    }
    
    func error() {
        post("searchError")
    }
    
}
