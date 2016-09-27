//
//  MinuteTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/25/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import XCTest
@testable import Icicle

class MinuteTest: XCTestCase {
    func testCreation() {
        let data = ["precipIntensity":0.1,"precipProbability":0.35,"time":1474831584,"precipType":"snow"] as [String : Any]
        let minute: Minute? = decode(data)
        
        XCTAssertEqual(minute!.time, 1474831584)
        XCTAssertEqual(minute!.precipType, "snow")
        XCTAssertEqualWithAccuracy(minute!.precipIntensity!, 0.1, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(minute!.precipProbability!, 0.35, accuracy: 0.01)
    }
}
