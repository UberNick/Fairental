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
    
    @IBOutlet weak var dateToolbar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: SearchViewModel!
    var dateButtonEdited: UIButton?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        hideDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchField.text = viewModel.address
        pickupButton.setTitle(viewModel.displayPickup, for: .normal)
        dropoffButton.setTitle(viewModel.displayDropoff, for: .normal)
    }
    
    //MARK: - IBActions
    @IBAction func dateButtonTapped(_ sender: Any) {
        dateButtonEdited = sender as? UIButton
        showDatePicker(animated: true)
        if dateButtonEdited === pickupButton {
            datePicker.date = viewModel.pickup
        } else if dateButtonEdited === dropoffButton {
            datePicker.date = viewModel.dropoff
        } else {
            datePicker.date = Date()
        }
    }
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        hideDatePicker()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        hideAllInputControls()
        SearchDelegate(viewModel).execute()
    }
    
    @IBAction func dateDoneTapped(_ sender: Any) {
        hideDatePicker(animated: true)
        if dateButtonEdited === pickupButton {
            viewModel.pickup = datePicker.date
        } else if dateButtonEdited === dropoffButton {
            viewModel.dropoff = datePicker.date
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        hideAllInputControls()
    }
    
    //MARK: - Hide/Show Functions
    func showDatePicker(animated: Bool = false) {
        hideKeyboard()
        datePicker.isHidden = false
        dateToolbar.isHidden = false
    }
    
    func hideDatePicker(animated: Bool = false) {
        dateButtonEdited = nil
        datePicker.isHidden = true
        dateToolbar.isHidden = true
    }
    
    func hideKeyboard() {
        searchField.resignFirstResponder()
    }
    
    func hideAllInputControls(animated: Bool = false) {
        hideDatePicker(animated: animated)
        hideKeyboard()
    }
}
