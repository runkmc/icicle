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
		let testData = ["icon":"partly-cloudy-night",
			"apparentTemperature":54.4, "temperature":54]
			let current = Currently(data:testData)
			XCTAssertEqual(current!.icon, "partly-cloudy-night")
	}
}
