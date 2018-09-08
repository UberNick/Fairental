//
//  VehicleInfo.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

struct VehicleInfo: Codable {
    var acrissCode: String
    var transmission: String
    var fuel: String
    var airConditioning: Bool
    var category: String
    var type: String
}
