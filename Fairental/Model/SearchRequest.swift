//
//  SearchRequest.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

struct SearchRequest: Codable {
    var latitude: String //double
    var longitude: String //double
    var radius: String //int
    var pickUp: String
    var dropOff: String    
}
