//
//  HourTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/30/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class HourTest: XCTestCase {

	func testHourCreation() {
		let json = ["apparentTemperature":65.5, "humidity":0.55,
			"precipIntensity":0, "precipProbability":0, "summary":"Partly Cloudy", 
			"temperature":65.5, "time":1460008800,
			"icon":"partly-cloudy-night"] as [String : Any]
        let hour = Hour(data:json as JSONDictionary)
        XCTAssertEqual(hour.icon, "partly-cloudy-night")
        XCTAssertEqual(hour.apparentTemperature, 65.5)
	}
}
