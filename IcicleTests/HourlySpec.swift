//
//  HourlySpec.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Nimble
import Quick
@testable import Icicle

class HourlySpec: QuickSpec {
    var bugfix = "" // thanks, swift.
    
    override func spec() {
        describe("Hourly") {
            let bundle = NSBundle(forClass: self.dynamicType)
            let path = bundle.pathForResource("icicle_test", ofType: "json")
            let data = NSData(contentsOfFile: path!)!
            let json = parseJSON(data, granularity: .Hour)
            let h: Decoded<Hourly> = decode(json)
            let hours = h.value!
            
            it("parses JSON and has attributes") {
                expect(hours.icon) == "partly-cloudy-day"
                expect(hours.summary) == "Mostly cloudy throughout the day."
            }
        }
    }
}