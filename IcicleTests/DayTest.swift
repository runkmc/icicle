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
        let bundle = Bundle(for: self.dynamicType)
        let path = bundle.url(forResource: "icicle_test", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = parseJSON(data: data, granularity: .Day)
        let days = json["data"] as! [AnyObject]
        let day = Day(data:days[0] as! JSON)
        
        XCTAssertEqual(day?.icon, "partly-cloudy-day")
    }
}
