//
//  CurrentlyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/11/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class CurrentlyTest: XCTestCase {
	func testCurrentlyCreation() {
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let json = try! parseJSON(data: data, granularity: .current)
        let currently = Currently(data: json)
        
        XCTAssertEqual(currently.time, 1460009818)
	}
}
