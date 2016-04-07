//
//  DailySpec.swift
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

class DailySpec: QuickSpec {
    var bugfix = ""
    
    override func spec() {
        describe("Daily") {
            let bundle = NSBundle(forClass: self.dynamicType)
            let path = bundle.pathForResource("icicle_test", ofType: "json")
            let data = NSData(contentsOfFile: path!)!
            let json = parseJSON(data, granularity: .Day)
            let d: Decoded<Daily> = decode(json)
            let daily = d.value!
            
            it("decoded JSON and has properties") {
                expect(daily.icon) == "rain"
                expect(daily.summary) == "Light rain on Friday through Wednesday, with temperatures falling to 57°F on Sunday."
            }
            
        }
    }
}