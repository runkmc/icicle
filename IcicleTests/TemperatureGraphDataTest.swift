//
//  TemperatureGraphDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class TemperatureGraphDataTest: XCTestCase {
    
    func testHourlyCreation() {
        let data = getTestJSON(named: "icicle_test", forClass: type(of:self))
        let json = try! parseJSON(data: data, granularity: .hour)
        let hours = Hours(data: json)
        let currentJson = try! parseJSON(data: data, granularity: .current)
        let currently = Currently(data: currentJson)
        let tempGraph = TemperatureGraphData(currently: currently, hours: hours, timezone:TimeZone(abbreviation: "PST")!)!
        
        XCTAssertEqual(tempGraph.currentDataPoint, "64°")
        XCTAssertEqual(tempGraph.highLabel, "69°")
        XCTAssertEqual(tempGraph.lowLabel, "58°")
        XCTAssertEqual(tempGraph.xAxisLabels[0], "11")
    }
    
    // func testDailyCreation() {
    //     let data = getTestJSON(named: "icicle_test", forClass: type(of:self))
    //     let json = try! parseJSON(data: data, granularity: .day)
    //     let days = Days(data: json)
    //     let currentJson = try! parseJSON(data:data, granularity: .current)
    //     let currently = Currently(data: currentJson)
    //     let tempGraph = TemperatureGraphData(currently:currently, days:days, timezone:TimeZone(abbreviation: "PST")!)!
    // }
}
