//
//  Car.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

struct Car: Codable {
    var vehicleInfo: VehicleInfo
    var rates: [Rate]
    var estimatedTotal: Price
}
