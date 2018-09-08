//
//  SearchResponse.swift
//  Fairental
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

struct SearchResponse: Codable {
    var results: [SearchResult]
}

struct SearchResult: Codable {
    var provider: CarProvider
    var location: Location?
    var airport: String?
    var cars: [Car]
}
