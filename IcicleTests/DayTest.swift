//
//  DayTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
@testable import Icicle

class DayTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "cloudy-futurerain", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .day)
        let dayJSON = json.successValue()!
        let days = dayJSON["data"] as! [AnyObject]
        let day: Day? = decode(days[0] as! [String:Any])
        
        XCTAssertEqual(day!.time, 1474776000)
        XCTAssertEqual(day!.summary, "Partly cloudy starting in the afternoon, continuing until evening.")
        XCTAssertEqual(day!.icon, "partly-cloudy-day")
        XCTAssertEqual(day!.sunriseTime!, 1474799592)
        XCTAssertEqual(day!.sunsetTime!, 1474842842)
        XCTAssertEqualWithAccuracy(day!.moonPhase!, 0.83, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(day!.precipIntensity!, 0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(day!.precipProbability!, 0, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(day!.temperatures.temperatureMax, 62.92, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(day!.temperatures.temperatureMin, 45.86, accuracy: 0.01)
    }
}
