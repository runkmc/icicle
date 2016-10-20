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
        let models = WeatherModels(currently: currently.value!, minutes: minutes.value!, hours: hours.value!, days: days.value!)
        
        let wd = WeatherData.create(models: models)
        return wd.successValue()!
    }

    func testSummary() {
        let wd = setupWeather(jsonFile: "sunny-hot")
        XCTAssertEqual(wd.fullSummary, "Currently 83°, but feels like 81°. Clear for the hour. Dry throughout the day. No precipitation throughout the week, with temperatures falling to 67°F on Sunday.")
    }
}
