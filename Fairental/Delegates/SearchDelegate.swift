//
//  SearchDelegate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class SearchDelegate {
    func execute(_ model: SearchViewModel) {
        let notification = Notification.Name("searchExecute")
        NotificationCenter.default.post(name: notification, object: nil)
        result()
    }
    
    func result() {
        let notification = Notification.Name("searchResult")
        NotificationCenter.default.post(name: notification, object: nil)
    }
}
