//
//  ResultViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, Listenable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: ResultViewModel!
    var selectedDetails: DetailViewModel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ResultViewModel()
        listen(SearchDelegate.Notification.execute.rawValue, #selector(resultsWillLoad))
        listen(SearchDelegate.Notification.response.rawValue, #selector(resultsDidLoad))
        listen(SearchDelegate.Notification.error.rawValue, #selector(resultsDidLoad))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.viewModel = selectedDetails
        }        
    }
    
    //MARK: - Notification Handlers
    @objc func resultsWillLoad(notification: Notification) {
        navigationController?.popToViewController(self, animated: false)
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
    }
    
    @objc func resultsDidLoad(notification: Notification) {
        viewModel.results = (notification.object as? SearchResponse)?.results ?? []
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView Datasource
extension ResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results[section].cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = createCell()        
        cell.textLabel?.text = viewModel.getTitleText(indexPath)
        cell.detailTextLabel?.text = viewModel.getDetailText(indexPath)
        return cell
    }
    
    func createCell() -> UITableViewCell {
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "resultCell") {
            return reuseCell
        }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "resultCell")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - TableView Delegate
extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getProvider(section).companyName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDetails = viewModel.getDetailViewModel(indexPath)
        performSegue(withIdentifier: "detailView", sender: self)
    }
}
