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

class MinutelyTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of: self))
        let json = parseJSON(data: data, granularity: .minute)
        let minutley: Decoded<Minutely> = decode(json.successValue()!)
        let m = minutley.value!
        XCTAssertEqual(m.summary, "Clear for the hour.")
        XCTAssertEqual(m.minutes[0].time, 1474830480)
    }
}
