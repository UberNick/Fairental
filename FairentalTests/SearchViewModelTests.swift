//
//  SearchViewModelTests.swift
//  FairentalTests
//
//  Created by Nick Matelli on 9/3/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import XCTest
@testable import Fairental

class SearchViewModelTests: XCTestCase {
    var target: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        target = SearchViewModel()
    }
    
    func testToday() {
        let date = Date()
        let dateLabel = target.formatted(date)
        XCTAssertEqual("Today", dateLabel)
    }
    
    func testTomorrow() {
        var date = Date()
        let day: Double = 60 * 60 * 24
        date = date.addingTimeInterval(day)
        let dateLabel = target.formatted(date)
        XCTAssertEqual("Tomorrow", dateLabel)
    }
    
    func testDDay() {
        let components: DateComponents = DateComponents(calendar: Calendar.current, year: 1944, month: 06, day: 06)
        let dateLabel = target.formatted(components.date!)
        XCTAssertEqual("Tuesday, June 6", dateLabel)
    }
        
}
