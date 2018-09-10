//
//  SearchDelegateTests.swift
//  FairentalTests
//
//  Created by Nick Matelli on 9/8/18.
//  Copyright © 2018 Foo. All rights reserved.
//

import XCTest
@testable import Fairental

class SearchDelegateTests: XCTestCase {
    var target: SearchDelegate!
    
    override func setUp() {
        super.setUp()
        target = SearchDelegate(SearchViewModel())
    }
    
    func testParseResults() {
        let data = loadJSON("SearchResponse")
        XCTAssertNotNil(data)
        let parsedData = target.decodeData(data)
        XCTAssertEqual("XXAR", parsedData?.results.first?.cars.first?.vehicleInfo.acrissCode)
    }
    
    func loadJSON(_ fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}
