//
//  TimelessDate.swift
//  Fairental
//
//  Created by Nick Matelli on 9/4/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import Foundation

struct TimelessDate: Codable, Equatable {
    private var _date: Date
    var date: Date { return _date }
    
    private var _string: String
    var string: String { return _string }
    
    static var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
    
    init() {
        _date = Date()
        _string = TimelessDate.formatter.string(from: _date)
    }
    
    init?(string: String?) {
        // If no string passed in, consider invalid
        guard let string = string else {
            return nil
        }
        _string = string
        
        guard let date = TimelessDate.formatter.date(from: string) else {
            return nil
        }
        _date = date
    }
    
    init?(date: Date?) {
        guard let date = date else {
            return nil
        }
        _date = date
        _string = TimelessDate.formatter.string(from: date)
    }
    
    public init(from decoder: Decoder) throws {
        let string: String = try decoder.singleValueContainer().decode(String.self)
        self.init(string: string)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}
