//
//  CarDetailViewController.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var car: Car!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        label.text = car.vehicleInfo.acrissCode
    }
}
