//
//  MinutleyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/26/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class MinutesTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of: self))
        let json = timeParser(data: data, granularity: .minute)
        let minutes: Decoded<Minutes> = decode(json.successValue()!)
        let m = minutes.value!
        XCTAssertEqual(m.summary, "Clear for the hour.")
        XCTAssertEqual(m.minutes[0].time, 1474830480)
    }
}
