//
//  CurrentlyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/8/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class CurrentlyTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of: self))
        let json = timeParser(data: data, granularity: .current)
        let currently: Decoded<Currently> = decode(json.successValue()!)
        let c = currently.value!
        
        XCTAssertEqual(c.time, 1474830537)
        XCTAssertEqual(c.summary!, "Clear")
        XCTAssertEqualWithAccuracy(c.temperature, 83.12, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(c.apparentTemperature!, 81.45, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(c.precipProbability!, 0, accuracy: 0.001)
        XCTAssertNil(c.precipType)
    }
}
