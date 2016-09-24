//
//  DayTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class DayTest: XCTestCase {
    
    func testDayCreation() {
        let data = getTestJSON(named:"icicle_test", forClass:type(of: self))
        let json = try! parseJSON(data: data, granularity: .day)
        let days = json["data"] as! [AnyObject]
        let day = Day(data:days[0] as! JSONDictionary)
        
        XCTAssertEqual(day.icon, "partly-cloudy-day")
    }
}
