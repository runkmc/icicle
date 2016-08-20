//
//  WeatherDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit
import XCTest
@testable import Icicle

class WeatherDataTest: XCTestCase {
    
    var weatherData: WeatherData!
    
    override func setUp() {
        let data = getTestJSON(named: "icicle_test", forClass: self.dynamicType)
        let minutesData = try! parseJSON(data: data, granularity: .minute)
        let hoursData = try! parseJSON(data: data, granularity: .hour)
        let daysData = try! parseJSON(data: data, granularity: .day)
        let currentData = try! parseJSON(data: data, granularity: .current)
        
        let minutes = Minutes(data:minutesData)
        let hours = Hours(data:hoursData)
        let days = Days(data:daysData)
        let current = Currently(data: currentData)
        
        self.weatherData = WeatherData(minutes:minutes, hours:hours, days:days, currently:current)

    }
    
    func testIcon() {
        
    }
}
