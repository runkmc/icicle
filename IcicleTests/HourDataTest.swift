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
    }
}
