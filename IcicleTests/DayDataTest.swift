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
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let json = parseJSON(data: data, granularity: .day)
        let dayJSON = json.successValue()!
        let days = dayJSON["data"] as! [AnyObject]
        let dayInfo: Decoded<Day> = decode(days[0] as! [String:Any])
        let day = DayData.create(decodedDay:dayInfo).successValue()!

        XCTAssertEqual("9/25", day.date)
    }
    
}
