//
//  DaySpec.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/7/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Argo
@testable import Icicle

class DaySpec: QuickSpec {
    var bugfix = ""
    
    override func spec() {
        describe("A Day") {
            let bundle = NSBundle(forClass: self.dynamicType)
            let path = bundle.pathForResource("icicle_test", ofType: "json")
            let data = NSData(contentsOfFile: path!)!
            let json = parseJSON(data, granularity: .Day)
            let d: Decoded<Daily> = decode(json)
            let days = d.value!
            let day = days.data[0]
            
            it("parses JSON and has attributes") {
                expect(day.icon) == "partly-cloudy-day"
                expect(day.moonPhase) == 0.97
                expect(day.precipIntensity) == 0
                expect(day.precipIntensityMax) == 0
                expect(day.precipProbability) == 0
                expect(day.sunriseTime) == 1459950459
                expect(day.sunsetTime) == 1459996701
                expect(day.temperatureMax) == 78.52
                expect(day.temperatureMaxTime) == 1459990800
                expect(day.temperatureMin) == 56.87
                expect(day.temperatureMinTime) == 1459944000
                expect(day.time) == 1459926000
            }
        }
    }
}
