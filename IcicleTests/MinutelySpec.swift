//
//  MinutelySpec.swift
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

class MinutelySpec: QuickSpec {
    var bugfix = "" // thanks swift.
    
    override func spec() {
        describe("Minutely") {
            let bundle = NSBundle(forClass: self.dynamicType)
            let path = bundle.pathForResource("icicle_test", ofType: "json")
            let data = NSData(contentsOfFile: path!)!
            let json = parseJSON(data, granularity: .Minute)
            //let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
            //let j = json!["minutely"]!
            let m: Decoded<Minutely> = decode(json!)
            let minutes = m.value!
            
            it("parses JSON and has the philsophical attribute of existence") {
                expect(minutes.icon) == "clear-day"
                expect(minutes.summary) == "Clear for the hour."
            }
        }
    }
}

