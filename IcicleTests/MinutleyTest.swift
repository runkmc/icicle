//
//  MinutleyTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

class MinutleyTest: XCTestCase {
    
    func testMinutleyCreation() {
        let bundle = Bundle(for: self.dynamicType)
        let path = bundle.url(forResource: "icicle_test", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = parseJSON(data:data, granularity: .Minute)
        let minutley = Minutley(data:json)!
        XCTAssertEqual(minutley.summary, "Partly cloudy for the hour.")
        XCTAssertEqual(minutley.minutes[0]!.precipIntensity, 0)
        XCTAssertEqual(minutley.icon, "partly-cloudy-night")
    }
    
    func testFailableInit() {
        let json = ["theBadJson":"so bad"]
        let minutley = Minutley(data: json)
        XCTAssertNil(minutley)
    }
}
