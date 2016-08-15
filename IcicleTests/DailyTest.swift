//
//  DailyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class DailyTest: XCTestCase {
    
    func testDailyCreation() {
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let json = parseJSON(data: data, granularity: .Day)
        let day = Daily(data: json)!
        
        XCTAssertEqual(day.summary, "Light rain on Friday through Wednesday, with temperatures falling to 57°F on Sunday.")
    }
}
