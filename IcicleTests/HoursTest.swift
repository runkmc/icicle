//
//  HoursTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class HoursTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "cloudy-futurerain", forClass: type(of:self))
        let json = timeParser(data: data, granularity: .hour)
        let hours: Decoded<Hours> = decode(json.successValue()!)
        let h = hours.value!
        
        XCTAssertEqual(h.summary, "Partly cloudy until this evening.")
        XCTAssertEqual(h.icon!, "partly-cloudy-day")
        XCTAssertEqualWithAccuracy(h.hours[0].temperature!, 60.84, accuracy: 0.01)
    }
}
