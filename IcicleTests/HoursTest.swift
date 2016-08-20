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

class HoursTest: XCTestCase {
    func testHoursCreation() {
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let json = try! parseJSON(data: data, granularity: .hour)
        let hours = Hours(data:json)
        XCTAssertEqual(hours.summary, "Mostly cloudy throughout the day.")
        XCTAssertEqual(hours.hours[0].time, 1460008800)
    }
}
