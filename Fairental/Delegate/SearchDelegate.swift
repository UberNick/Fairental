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
    
    enum Notification: String {
        case execute = "SearchDelegate.execute"
        case response = "SearchDelegate.response"
        case error = "SearchDelegate.error"
    }
    
    init(_ model: SearchViewModel) {
        requestData = SearchRequest(
            latitude: 35.1504,
            longitude: -114.57632,
            radius: 42,
            pickUp: TimelessDate(string: "2018-12-07")!,
            dropOff: TimelessDate(string: "2018-12-08")!)
    }
    
    func execute() {
        post(Notification.execute.rawValue)
        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = parameterize(requestData)
        guard let url = urlComponents?.url else {
            error()
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request, completionHandler: response).resume()
    }
    
    func response(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data else {
            self.error()
            return
        }
        post(Notification.response.rawValue, decodeData(data))
    }
    
    func error() {
        post(Notification.error.rawValue)
    }
    
    func decodeData(_ data: Data?) -> SearchResponse? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else {
            return nil
        }
        var result: SearchResponse? = nil
        do {
            result = try decoder.decode(SearchResponse.self, from: data)
        } catch {
            let rawResponse = String(data: data, encoding: .utf8)
            print("Error parsing response: \(rawResponse ?? ""))")
            print(error)
        }
        return result
    }
}
