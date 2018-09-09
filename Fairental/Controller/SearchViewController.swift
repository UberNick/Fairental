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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue from search VC: \(segue)")
    }
    
    //MARK: - IBActions
    @IBAction func dateButtonTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        dateButtonEdited = button
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
        // open results page
        (parent as? UITabBarController)?.selectedIndex = 1
        SearchDelegate(viewModel).execute()
    }
    
    @IBAction func dateDoneTapped(_ sender: Any) {
        hideDatePicker(animated: true)
        
        if dateButtonEdited === pickupButton {
            viewModel.pickup = datePicker.date
            pickupButton.setTitle(viewModel.displayPickup, for: .normal)
        } else if dateButtonEdited === dropoffButton {
            viewModel.dropoff = datePicker.date
            dropoffButton.setTitle(viewModel.displayDropoff, for: .normal)
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
