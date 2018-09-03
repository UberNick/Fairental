//
//  SearchViewModel.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

struct SearchViewModel {
    var address: String = ""
    var pickup: Date = Date()
    var dropoff: Date = Date()
    
    var displayPickup: String {
        return "Today at Noon"
    }
    
    var displayDropoff: String {
        return "Tomorrow at 5:00pm"
    }
}
