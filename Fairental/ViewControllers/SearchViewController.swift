//
//  SearchViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var pickupButton: UIButton!
    @IBOutlet weak var dropoffButton: UIButton!
    
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchField.text = viewModel.address
        pickupButton.setTitle(viewModel.displayPickup, for: .normal)
        dropoffButton.setTitle(viewModel.displayDropoff, for: .normal)
    }
    
    @IBAction func pickupTapped(_ sender: Any) {
        // show date search input
    }
    
    @IBAction func dropoffTapped(_ sender: Any) {
        // show date search input
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let notification = Notification.Name("search")
        NotificationCenter.default.post(name: notification, object: viewModel)
    }
}
