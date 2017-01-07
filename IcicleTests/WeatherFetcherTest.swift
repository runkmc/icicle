//
//  WeatherFetcherTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/6/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import Icicle

class WeatherFetcherTest: XCTestCase {
    let locService = SavedLocationService(location:
        Location(coordinates: CLLocation(latitude:10, longitude:-10), name: "Default City"))
    
    struct EmptySession: DataTask {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
            return URLSessionDataTaskStub()
        }
    }
    
    func testBadURLString() {
        // ^ is an invalid character in URLs
        weatherFetcher(locationService:locService, session:EmptySession(), key: "^") { result in
            XCTAssertTrue(Result.isError(result))
            XCTAssertEqual(result.errorValue()?.first, "Problem creating url string: https://api.darksky.net/forecast/^/10.0,-10.0")
        }
    }
}
