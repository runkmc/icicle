//
//  ParseTimeZoneTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 11/23/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class ParseTimeZoneTest: XCTestCase {
    func testPacificDaylight() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let tz = parseTimeZone(data: data).successValue()!
        XCTAssertEqual(tz.localizedName(for: .generic, locale: Locale.current), "Pacific Time")
    }
}
