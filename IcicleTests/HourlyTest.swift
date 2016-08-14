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
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let json = parseJSON(data: data, granularity: .Hour)
        let hourly = Hourly(data:json)!
        XCTAssertEqual(hourly.summary, "Mostly cloudy throughout the day.")
        XCTAssertEqual(hourly.hours[0]!.time, 1460008800)
    }
}
