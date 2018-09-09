//
//  ResultViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listen(SearchDelegate.Notification.execute.rawValue, #selector(resultsWillLoad))
        listen(SearchDelegate.Notification.response.rawValue, #selector(resultsDidLoad))
        listen(SearchDelegate.Notification.execute.rawValue, #selector(resultsDidLoad))
    }
    
    //MARK: - Notification Handlers
    @objc func resultsWillLoad(notification: Notification) {
        print("will load")
    }
    
    @objc func resultsDidLoad(notification: Notification) {
        print("did load")
        print(notification.object)
    }
    
    func listen(_ notificationName: String, _ selector: Selector) {
        let notification = Notification.Name(notificationName)
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
}
