//
//  HourSpec.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Argo
@testable import Icicle

class HourSpec: QuickSpec {
    var bugfix = "" // getting old.
    
    override func spec() {
        describe("An hour") {
            let bundle = NSBundle(forClass: self.dynamicType)
            let path = bundle.pathForResource("icicle_test", ofType: "json")
            let data = NSData(contentsOfFile: path!)!
            let json = parseJSON(data, granularity: .Hour)
            let h: Decoded<Hourly> = decode(json)
            let hours = h.value!
            let hour = hours.data[0]
            
            it("parses JSON and has attributes") {
                expect(hour.apparentTemperature) == 65.58
                expect(hour.cloudCover) == 0.55
                expect(hour.humidity) == 0.53
                expect(hour.icon) == "partly-cloudy-night"
                expect(hour.precipIntensity) == 0
                expect(hour.precipProbability) == 0
                expect(hour.summary) == "Partly Cloudy"
                expect(hour.temperature) == 65.58
                expect(hour.time) == 1460008800
            }
        }
    }
}