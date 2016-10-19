//
//  WeatherDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/15/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import Argo
@testable import Icicle

class WeatherDataTest: XCTestCase {
    func setupWeather(jsonFile:String) -> WeatherData {
        let data = getTestJSON(named: jsonFile, forClass: type(of:self))
        let currentlyJson = parseJSON(data: data, granularity: .current)
        let minutesJson = parseJSON(data: data, granularity: .minute)
        let hoursJson = parseJSON(data: data, granularity: .hour)
        let daysJson = parseJSON(data: data, granularity: .day)
        
        let currently: Decoded<Currently> = decode(currentlyJson.successValue()!)
        let minutes: Decoded<Minutes> = decode(minutesJson.successValue()!)
        let hours: Decoded<Hours> = decode(hoursJson.successValue()!)
        let days: Decoded<Days> = decode(daysJson.successValue()!)
        
        return WeatherData(currently: currently.value!, minutely: minutes.value!, hourly: hours.value!, daily: days.value!)
    }

}
