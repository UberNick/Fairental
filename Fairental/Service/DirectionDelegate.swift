//
//  DirectionDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class DirectionDelegate: Networkable, Notifiable {
        
    enum Notification: String {
        case execute = "DirectionDelegate.execute"
        case response = "DirectionDelegate.response"
        case error = "DirectionDelegate.error"
    }
    
    init(_ model: DetailViewModel) {
        
    }
    
    func execute() {
        post(Notification.execute.rawValue)
    }
    
    func response(data: Data?, response: URLResponse?, error: Error?) {
        post(Notification.response.rawValue)
    }
}
