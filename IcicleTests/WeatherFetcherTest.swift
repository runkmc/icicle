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
            switch result.errorValue()! {
            case .urlError(let value): XCTAssertEqual(value, "Problem creating url string: https://api.darksky.net/forecast/^/10.0,-10.0")
            default: XCTFail()
            }
        }
    }
    
    struct ContainsErrorSession: DataTask {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
            completionHandler(nil, nil, NSError(domain: "YA DONE MESSED UP", code: 0, userInfo: nil))
            return URLSessionDataTaskStub()
        }
    }
    
    func testBadResponse() {
        weatherFetcher(locationService: locService, session: ContainsErrorSession(), key: "123") { result in
            switch result.errorValue()! {
            case .httpError(let value): XCTAssertEqual(value, "I found an error instead of the weather. Sorry about that.")
            default: XCTFail()
            }
        }
    }
    
    struct BadJSONSession: DataTask {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
            let data = getTestJSON(named: "eight-days", forClass: WeatherFetcherTest.self)
            completionHandler(data, nil, nil)
            return URLSessionDataTaskStub()
        }
    }
    
    func testBadJSON() {
        weatherFetcher(locationService: locService, session: BadJSONSession(), key: "1") { result in
            switch result.errorValue()! {
            case .decodingError(let value): XCTAssertEqual(value, "NSCocoaErrorDomain")
            default: XCTFail()
            }
        }
    }
    
    struct IncompleteDataSession: DataTask {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
            let data = getTestJSON(named: "historical-snow", forClass: WeatherFetcherTest.self)
            completionHandler(data, nil, nil)
            return URLSessionDataTaskStub()
        }
    }
    
    func testIncompleteJSON() {
        weatherFetcher(locationService: locService, session: IncompleteDataSession(), key: "1") { result in
            switch result.errorValue()! {
            case .decodingError(let value): XCTAssertEqual(value, "minutely data not found")
            default: XCTFail()
            }
        }
    }
    
    struct GoodSession: DataTask {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
            let data = getTestJSON(named: "sunny-hot", forClass: WeatherFetcherTest.self)
            completionHandler(data, nil, nil)
            return URLSessionDataTaskStub()
        }
    }
    
    func testGoodData() {
        weatherFetcher(locationService: locService, session: GoodSession(), key: "1") { result in
            let weather = result.successValue()!
            let day = weather.days[0]
            XCTAssertEqual("56° at 6 AM", day.low)
        }
    }
}
