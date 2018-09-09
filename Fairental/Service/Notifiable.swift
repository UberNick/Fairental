//
//  Notifiable.swift
//  Fairental
//
//  Created by Nick Matelli on 9/9/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

protocol Notifiable {
    func post(_ notification: String, _ payload: Any?)
}

extension Notifiable {
    func post(_ notification: String, _ payload: Any? = nil) {
        let notificationName = Notification.Name(notification)
        NotificationCenter.default.post(name: notificationName, object: payload)
    }
}
