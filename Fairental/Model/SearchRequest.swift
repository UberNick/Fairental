//
//  SearchRequest.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

struct SearchRequest: Codable {
    var latitude: Double
    var longitude: Double
    var radius: Int
    var pickUp: TimelessDate
    var dropOff: TimelessDate
}
