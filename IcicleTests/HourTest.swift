//
//  HourTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class HourTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "historical-snow", forClass: type(of:self))
        let json = timeParser(data: data, granularity: .hour)
        let hourJSON = json.successValue()!
        let hours = hourJSON["data"] as! [AnyObject]
        let hour: Hour? = decode(hours[5] as! [String:Any])
        
        XCTAssertEqualWithAccuracy(hour!.apparentTemperature!, 6.66, accuracy: 0.01)
        XCTAssertEqual(hour!.time, 1456826400)
        XCTAssertEqual(hour!.icon, "snow")
        XCTAssertEqualWithAccuracy(hour!.precipProbability!, 0.46, accuracy: 0.01)
        XCTAssertEqual(hour!.precipType!, "snow")
        XCTAssertEqualWithAccuracy(hour!.temperature!, 20.52, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(hour!.humidity!, 0.84, accuracy: 0.01)
        XCTAssertEqual(hour!.summary, "Snow")
    }
}
