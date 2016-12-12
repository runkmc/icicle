//
//  HourDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/3/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
@testable import Icicle

class HourDataTest: XCTestCase {
    func testSunnyCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .hour)
        let hourJSON = json.successValue()!
        let hours = hourJSON["data"] as! [AnyObject]
        let hourInfo: Decoded<Hour> = decode(hours[0] as! [String:Any])
        let timeZone = parseTimeZone(data: data).successValue()!
        let hour = HourData.create(hourInfo, timeZone:timeZone).successValue()!
        
        XCTAssertEqual("12 PM", hour.time)
        XCTAssertEqual("Clear", hour.summary)
        XCTAssertEqual("82°", hour.temperature)
        XCTAssertEqual("0%", hour.precipChance)
        XCTAssertEqual("—", hour.precipType)
        XCTAssertEqual("81°", hour.apparentTemperature)
    }
    
    func testRainyCreation() {
        let data = getTestJSON(named: "cloudy-futurerain", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .hour)
        let hourJSON = json.successValue()!
        let hours = hourJSON["data"] as! [AnyObject]
        let hourInfo: Decoded<Hour> = decode(hours[44] as! [String:Any])
        let timeZone = parseTimeZone(data: data).successValue()!
        let hour = HourData.create(hourInfo, timeZone:timeZone).successValue()!
        
        XCTAssertEqual("11 AM", hour.time)
        XCTAssertEqual("Rain", hour.summary)
        XCTAssertEqual("61°", hour.temperature)
        XCTAssertEqual("61%", hour.precipChance)
        XCTAssertEqual("Rain", hour.precipType)
        XCTAssertEqual("61°", hour.apparentTemperature)
    }

}
