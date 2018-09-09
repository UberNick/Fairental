//
//  ResultViewModel.swift
//  Fairental
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class ResultViewModel {
    var results: [SearchResult] = []
    
    func getProvider(_ section: Int) -> CarProvider {
        return results[section].provider
    }
    
    func getLocation(_ section: Int) -> Location? {
        return results[section].location
    }
    
    func getCars(_ section: Int) -> [Car] {
        return results[section].cars
    }
    
    func getCar(_ indexPath: IndexPath) -> Car {
        return getCars(indexPath.section)[indexPath.row]
    }
    
    func getDetailViewModel(_ indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(
            car: getCar(indexPath),
            provider: getProvider(indexPath.section),
            location: getLocation(indexPath.section))
    }
    
    func getTitleText(_ indexPath: IndexPath) -> String {
        let car = getCar(indexPath)
        var s = car.vehicleInfo.category + " "
        s += car.vehicleInfo.type + " "
        s += car.vehicleInfo.transmission + " "
        if car.vehicleInfo.fuel != "Unspecified" {
            s += car.vehicleInfo.fuel
        }
        return s
    }
    
    func getDetailText(_ indexPath: IndexPath) -> String {
        let car = getCar(indexPath)
        var s = ""
        if car.estimatedTotal.currency == "USD" {
            s += "$" + car.estimatedTotal.amount
        } else {
            s += car.estimatedTotal.amount + " " + car.estimatedTotal.currency
        }
        return s
    }
}
