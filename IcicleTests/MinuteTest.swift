//
//  MinuteTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class MinuteTest: XCTestCase {
    
    func testMinuteCreation() {
        let data = ["time":1460009760, "precipIntensity":0, "precipProbability":0]
        let minute = Minute(data: data)!
        XCTAssertEqual(minute.time, 1460009760)
        XCTAssertEqual(minute.precipProbability, 0)
        XCTAssertEqual(minute.precipIntensity, 0)
    }
}
