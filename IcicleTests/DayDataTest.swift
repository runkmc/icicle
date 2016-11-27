//
//  DayDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 11/20/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
@testable import Icicle

class DayDataTest: XCTestCase {
    func testSunnyCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .day)
        let dayJSON = json.successValue()!
        let days = dayJSON["data"] as! [AnyObject]
        let dayInfo: Decoded<Day> = decode(days[0] as! [String:Any])
        let timeZone = parseTimeZone(data: data).successValue()!
        let day = DayData.create(dayInfo, timeZone:timeZone).successValue()!

        XCTAssertEqual("9/25", day.date)
        XCTAssertEqual("94° at 4PM", day.high)
        XCTAssertEqual("56° at 6AM", day.low)
        XCTAssertEqual("7:00 AM", day.sunrise)
        XCTAssertEqual("7:01 PM", day.sunset)
        XCTAssertEqual("None", day.precipChance)
    }
    
    func testRainyCreation() {
        let data = getTestJSON(named: "cloudy-futurerain", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .day)
        let dayJSON = json.successValue()!
        let days = dayJSON["data"] as! [AnyObject]
        let dayInfo: Decoded<Day> = decode(days[4] as! [String:Any])
        let timeZone = parseTimeZone(data: data).successValue()!
        let day = DayData.create(dayInfo, timeZone:timeZone).successValue()!
        
        XCTAssertEqual("9/29", day.date)
        XCTAssertEqual("65° at 4PM", day.high)
        XCTAssertEqual("56° at 11PM", day.low)
        XCTAssertEqual("6:37 AM", day.sunrise)
        XCTAssertEqual("6:26 PM", day.sunset)
        XCTAssertEqual("55%", day.precipChance)

    }
}
