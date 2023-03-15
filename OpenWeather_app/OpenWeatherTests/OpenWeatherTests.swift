//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Achref Ben Tekaya on 13/3/2023.
//

import XCTest
@testable import OpenWeather
@testable import OpenWeatherAPIs

final class OpenWeatherTests: XCTestCase {
    var openWeatherAPIs: OpenWeatherAPIs!

    override func setUp() {
        super.setUp()
        openWeatherAPIs = OpenWeatherAPIs(apiKey: "de79c9827949fa4d24bcdee6a6408c55")
    }

    func testFindCityCoordinates() {
        let expectation = self.expectation(description: "City List")
        
        //1st Test : Correct Name
        openWeatherAPIs.findCityCoordinates("Paris") { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            
            expectation.fulfill()
        }
        
        //2nd Test : Wrong Name
        openWeatherAPIs.findCityCoordinates("Lorem epsum") { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            if let errorCode = result.data()?["cod"] as? String {
                XCTAssertEqual(errorCode, "404")
            }

            expectation.fulfill()
        }
        
        //3rd Test : Empty Param
        openWeatherAPIs.findCityCoordinates("") { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            if let errorCode = result.data()?["cod"] as? String {
                XCTAssertEqual(errorCode, "404")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testRetreiveWeatherData() {
        let expectation = self.expectation(description: "City Weather")
        
        //1st Test : Correct Coordinates
        openWeatherAPIs.retreiveWeatherData(51.5073219, -0.1276474) { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            if let errorCode = result.data()?["cod"] as? String {
                XCTAssertEqual(errorCode, "400")
            }

            expectation.fulfill()
        }
        
        //2nd Test : Wrong Latitude
        openWeatherAPIs.retreiveWeatherData(9999999999, -0.1276474) { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            if let errorCode = result.data()?["cod"] as? String {
                XCTAssertEqual(errorCode, "400")
            }

            expectation.fulfill()
        }

        //3rd Test : Wrong Longitude
        openWeatherAPIs.retreiveWeatherData(51.5073219, 999999999) { result in
            XCTAssertNotNil(result.response())
            XCTAssertNil(result.error())
            XCTAssertNotNil(result.data())
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }


}
