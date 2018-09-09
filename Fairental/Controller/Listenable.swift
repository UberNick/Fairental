//
//  Listenable.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

protocol Listenable {
    func listen(_ notificationName: String, _ selector: Selector)
}

extension Listenable {
    func listen(_ notificationName: String, _ selector: Selector) {
        let notification = Notification.Name(notificationName)
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
}
