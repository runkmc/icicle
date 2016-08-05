//
//  HourlyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/5/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class HourlyTest: XCTestCase {
    func testHourlyCreation() {
        let bundle = Bundle(for: self.dynamicType)
        let path = bundle.url(forResource: "icicle_test", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = parseJSON(data: data, granularity: .Hour)
        let hourly = Hourly(data:json)!
        XCTAssertEqual(hourly.summary, "Mostly cloudy throughout the day.")
        XCTAssertEqual(hourly.hours[0]!.time, 1460008800)
    }
}
