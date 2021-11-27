//
//  MeaningDataTests.swift
//  MeaningTests
//
//  Created by 1212199 on 25/11/21.
//

import XCTest
@testable import Meaning

class MeaningDataTests: XCTestCase {

   private var exampleJSONTestData: Data!
   private var meaingData: MeaningData!
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "TestDataFile", withExtension: "json")!
        exampleJSONTestData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        meaingData = try! decoder.decode(MeaningData.self, from: exampleJSONTestData)
    }
    
    func testShortForm() throws {
        XCTAssertEqual(meaingData.shortForm, "AIDS")
    }
    
    func testMeaning() throws {
        XCTAssertEqual(meaingData.meaning, "acquired immunodeficiency syndrome")
    }
}
