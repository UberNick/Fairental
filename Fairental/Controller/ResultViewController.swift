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
    
    var results: [SearchResult] = []
    
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
        results = (notification.object as? SearchResponse)?.results ?? []
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func listen(_ notificationName: String, _ selector: Selector) {
        let notification = Notification.Name(notificationName)
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
}

// MARK: - TableView Datasource
extension ResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections: \(results.count)")
        return results.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection: \(results[section].cars.count)")
        return results[section].cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: "resultCell")
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "resultCell") {
            cell = reuseCell
        }
        let result = results[indexPath.section]
        let car = result.cars[indexPath.row]        
        cell.textLabel?.text = "\(car.vehicleInfo.acrissCode)"
        cell.detailTextLabel?.text = "\(car.vehicleInfo.type)"
        return cell
    }
}

// MARK: - TableView Delegate
extension ResultViewController: UITableViewDelegate {
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }*/
}
