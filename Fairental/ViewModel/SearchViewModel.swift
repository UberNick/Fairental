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
    var location: Location?
    var pickup: Date = Date()
    var dropoff: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date() // tomorrow
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter
    }()
    
    var displayPickup: String {
        return formatted(pickup)
    }
    
    var displayDropoff: String {
        return formatted(dropoff)
    }
    
    func formatted(_ date: Date) -> String {
        let dateString = TimelessDate(date: date)?.string
        let todayString = TimelessDate(date: Date())?.string
        let tomorrowString = TimelessDate(date: tomorrow)?.string
        
        if dateString == todayString {
            return "Today"
        } else if dateString == tomorrowString {
            return "Tomorrow"
        }        
        return formatter.string(from: date)
    }
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())
    }
}
