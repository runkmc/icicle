//
//  DaysTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/30/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class DaysTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .day)
        let days: Decoded<Days> = decode(json.successValue()!)
        let d = days.value!
        
        XCTAssertEqual(d.summary, "No precipitation throughout the week, with temperatures falling to 67°F on Sunday.")
        XCTAssertEqual(d.icon!, "clear-day")
        XCTAssertEqual(d.days[0].summary, "Dry throughout the day.")
    }

}
