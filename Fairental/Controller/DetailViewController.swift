//
//  DetailViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var categoryAndType: UILabel!
    
    @IBOutlet weak var acrissCode: UILabel!
    @IBOutlet weak var airConditioning: UILabel!    
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var transmission: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    var viewModel: DetailViewModel!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        companyName.text = viewModel.provider.companyName
        
        categoryAndType.text = viewModel.car.vehicleInfo.category + " " + viewModel.car.vehicleInfo.type
        
        acrissCode.text = viewModel.car.vehicleInfo.acrissCode
        airConditioning.text = viewModel.car.vehicleInfo.airConditioning ? "Yes" : "No"
        
        fuel.text = viewModel.car.vehicleInfo.fuel
        transmission.text = viewModel.car.vehicleInfo.transmission
        
        if viewModel.car.estimatedTotal.currency == "USD" {
            amount.text = "$" + viewModel.car.estimatedTotal.amount
        } else {
            amount.text = viewModel.car.estimatedTotal.amount + " " + viewModel.car.estimatedTotal.currency
        }
    }
    
    //MARK: - Actions
    @IBAction func directionButtonTapped(_ sender: Any) {
        DirectionDelegate(viewModel).execute()
        // open directions page
        (parent as? UITabBarController)?.selectedIndex = 2
    }
}
