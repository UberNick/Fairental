//
//  TimelessDateTests.swift
//  Fairental
//
//  Created by Nick Matelli on 9/4/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import XCTest

@testable import Fairental

class DateStringTests: XCTestCase {
    
    var epoch: Date = Date()
    
    var encoder: JSONEncoder = JSONEncoder()
    var decoder: JSONDecoder = JSONDecoder()
    
    override func setUp() {
        var interval = epoch.timeIntervalSince1970
        interval.negate()
        epoch = epoch.addingTimeInterval(interval)
    }
    
    func testInitFromDate() {
        let date = Date()
        let timelessDate = TimelessDate(date: date)
        XCTAssertEqual(ComparisonResult.orderedSame, difference(date, to: timelessDate?.date))
    }
    
    func testInitFromString() {
        let string = "1970-01-01"
        let timelessDate = TimelessDate(string: string)
        XCTAssertEqual(ComparisonResult.orderedSame, difference(epoch, to: timelessDate?.date, precision: .day))
    }
    
    func testNilInit() {
        XCTAssertNil(TimelessDate(date: nil))
        XCTAssertNil(TimelessDate(string: nil))
        XCTAssertNil(TimelessDate(string: ""))
    }
    
    func testStringFromToday() {
        let date = Date()
        let timelessDate = TimelessDate(date: date)
        let timelessString = String(timelessDate?.string.prefix(10) ?? "")
        let stringFromDate = stringFrom(date)
        XCTAssertEqual(stringFromDate, timelessString)
    }
    
    func testEncode() {
        guard let timelessDate = TimelessDate(string: "1970-01-01") else {
            XCTFail("nil timelessDate unexpected")
            return
        }
        var jsonString: String?
        let expectedJsonString = "[\"1970-01-01\"]" // single-value wrapped in array to make valid json
        do {
            let data = try encoder.encode([timelessDate])
            jsonString = String(data: data, encoding: .utf8)
        } catch {
            XCTFail("Encoding timelessDate failed")
        }
        XCTAssertEqual(expectedJsonString, jsonString)
    }
    
    func testDecode() {
        let jsonString = "[\"1970-01-01\"]"
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Decoding timelessDate failed")
            return
        }
        var timelessDates: [TimelessDate]?
        do {
            timelessDates = try decoder.decode([TimelessDate].self, from: jsonData)
        } catch {
            XCTFail("Decoding timelessDate failed")
        }
        let timelessDate = timelessDates?.first?.date
        XCTAssertEqual(ComparisonResult.orderedSame, difference(epoch, to: timelessDate))
    }
    
    // MARK: - Util
    
    // epoch calculation can be off by a second or two, so compare against minutes by default
    func difference(_ from: Date?, to: Date?, precision: Calendar.Component = Calendar.Component.minute) -> ComparisonResult? {
        guard let from = from, let to = to else {
            XCTFail("Nil dates unexpected")
            return nil
        }
        return Calendar.current.compare(from, to: to, toGranularity: precision)
    }
    
    // reverse compute string from date without using formatters
    func stringFrom(_ date: Date) -> String? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard let year = components.year, let month = components.month, let day = components.day else {
            XCTFail("Nil date components unexpected")
            return nil
        }
        let monthString = (month < 10) ? "0\(month)" : "\(month)"
        let dayString = (day < 10) ? "0\(day)" : "\(day)"
        return "\(year)-\(monthString)-\(dayString)"
    }
}
