//
//  MinutleyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class MinutesTest: XCTestCase {
    
    func testMinutesCreation() {
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let json = parseJSON(data:data, granularity: .Minute)
        let minutes = Minutes(data:json)
        XCTAssertEqual(minutes.summary, "Partly cloudy for the hour.")
        XCTAssertEqual(minutes.minutes[0].precipIntensity, 0)
        XCTAssertEqual(minutes.icon, "partly-cloudy-night")
    }
    
}
