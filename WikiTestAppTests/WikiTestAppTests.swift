//
//  WikiTestAppTests.swift
//  WikiTestAppTests
//
//  Created by Adam Lovastyik on 27/10/2019.
//  Copyright © 2019 Adam Lovastyik. All rights reserved.
//

import XCTest
@testable import WikiTestApp

class WikiTestAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Test Initialization with a string
    
    func testCustomLocationInitValid() {
        
        let location = CustomLocation(coordinates: "12,34")
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.coordinate.latitude, 12)
        XCTAssertEqual(location?.coordinate.longitude, 34)
    }
    
    func testCustomLocationInitFailNil() {
        
        let location = CustomLocation(coordinates: nil)
        XCTAssertNil(location)
    }

    func testCustomLocationInitFailEmptyString() {
        
        let location = CustomLocation(coordinates: "")
        XCTAssertNil(location)
    }

    func testCustomLocationInitFailInvalidString() {
        
        let location = CustomLocation(coordinates: "wrong")
        XCTAssertNil(location)
    }
    
    func testCustomLocationInitFailNotEnoghCoords() {
        
        let location = CustomLocation(coordinates: "1")
        XCTAssertNil(location)
    }
    
    func testCustomLocationInitFailTooManyCoords() {
        
        let location = CustomLocation(coordinates: "1,2,3")
        XCTAssertNil(location)
    }
    
    func testCustomLocationInitFailNonNumericCoords() {
        
        let location = CustomLocation(coordinates: "a,b")
        XCTAssertNil(location)
    }
    
    func testCustomLocationInitFailInvalidCoords() {
        
        let location = CustomLocation(coordinates: "400,500")
        XCTAssertNil(location)
    }
    
    // MARK: - Test URL construction
    
    func testURLConstruction() {
        
        let location = CustomLocation(coordinates: "12,34")
        XCTAssertNotNil(location)
        
        let url = location?.wikiURL
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.host, "places")
        
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        XCTAssertNotNil(components)
        XCTAssertEqual(components?.queryItems?.count, 1)
        XCTAssertEqual(components?.queryItems?.first?.name, "LACoordinate")
        XCTAssertEqual(components?.queryItems?.first?.value, "12.0,34.0")
    }
}
