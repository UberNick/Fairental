//
//  CarDetailViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var acrissCode: UILabel!
    @IBOutlet weak var airConditioning: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var transmission: UILabel!
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    var car: Car!
    var provider: CarProvider!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        companyName.text = provider.companyName
        
        type.text = car.vehicleInfo.type
        category.text = car.vehicleInfo.category
        acrissCode.text = car.vehicleInfo.acrissCode
        airConditioning.text = car.vehicleInfo.airConditioning ? "Yes" : "No"
        
        fuel.text = car.vehicleInfo.fuel
        transmission.text = car.vehicleInfo.transmission
                
        amount.text = car.estimatedTotal.amount + " " + car.estimatedTotal.currency
    }
}
