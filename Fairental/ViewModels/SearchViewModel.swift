//
//  SearchViewModel.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

class SearchViewModel {
    var address: String = ""
    var pickup: Date = Date()
    var dropoff: Date = Date()
    
    lazy var formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEE, MMM, d at h:mm a"
        return df
    }()
    
    var displayPickup: String {
        return "Today at Noon"
    }
    
    var displayDropoff: String {
        return "Tomorrow at 5:00pm"
    }
    
    func formatted(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}
