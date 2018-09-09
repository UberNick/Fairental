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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listen(SearchDelegate.Notification.execute.rawValue, #selector(resultsWillLoad))
        listen(SearchDelegate.Notification.response.rawValue, #selector(resultsDidLoad))
        listen(SearchDelegate.Notification.error.rawValue, #selector(resultsDidLoad))
    }
    
    //MARK: - Notification Handlers
    @objc func resultsWillLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    @objc func resultsDidLoad(notification: Notification) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
        
        if let results = notification.object {
            print("foo")
        }
        print("bar")
    }
    
    func listen(_ notificationName: String, _ selector: Selector) {
        let notification = Notification.Name(notificationName)
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
}
