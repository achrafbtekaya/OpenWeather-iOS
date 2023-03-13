//
//  OpenWeatherAPIsTests.swift
//  OpenWeatherAPIsTests
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import XCTest
@testable import OpenWeatherAPIs

class OpenWeatherAPIsTests: XCTestCase {
    var openWeatherAPIs: OpenWeatherAPIs!
    
    override func setUp() {
        super.setUp()
        openWeatherAPIs = OpenWeatherAPIs(apiKey: "de79c9827949fa4d24bcdee6a6408c55")
    }
    
    func testCurrentWeather() {
        let expectation = self.expectation(description: "Callback received")
        
        openWeatherAPIs.currentWeather("Paris") { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
