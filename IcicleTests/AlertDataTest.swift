//
//  AlertDataTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/16/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import XCTest
@testable import Icicle

class AlertDataTest: XCTestCase {
    func testCreation() {
        let data = getTestJSON(named: "sunny-hot", forClass: type(of:self))
        let alerts = alertParser(data: data).successValue()!
        let alertModel: Alert = decode(alerts[0] as! [String:Any])!
        let alert = AlertData.create(alertModel)
        
        XCTAssertEqual("Heat Advisory for Alameda, CA", alert.title)
        XCTAssertEqual("9/25 • 8:00 Pacific Time", alert.expires)
        XCTAssertEqual(URL(string:"https://alerts.weather.gov/cap/wwacapget.php?x=CA125614C77974.HeatAdvisory.125614D598B0CA.MTRNPWMTR.acc4602772d4b445b28cd8b1f1d59b8b"), alert.url)
        XCTAssertEqual("...VERY WARM TO HOT TEMPERATURES SUNDAY AND MONDAY FOR THE ENTIRE\nREGION...\n.A STRONG RIDGE OF HIGH PRESSURE WILL CONTINUE TO BUILD OVER THE\nREGION THROUGH THE REMAINDER OF THIS WEEKEND. THIS WILL RESULT IN\nVERY WARM TO HOT WEATHER WITH RECORD HIGH TEMPERATURES BOTH SUNDAY\nAND MONDAY. IN ADDITION...OFFSHORE FLOW WILL ALLOW VERY WARM AIR\nTO REACH ALL THE WAY TO THE COAST BOTH SUNDAY AND MONDAY. MANY\nAREAS ARE EXPECTED TO EXPERIENCE THEIR WARMEST TEMPERATURES OF THE\nYEAR OVER THE NEXT TWO DAYS.\n...HEAT ADVISORY REMAINS IN EFFECT FROM 11 AM THIS MORNING TO\n8 PM PDT THIS EVENING...\n...HEAT ADVISORY REMAINS IN EFFECT FROM 11 AM TO 8 PM PDT\nMONDAY...\n* TEMPERATURE...HIGHS WILL MOSTLY BE IN THE MID 80S TO MID 90S\nNEAR THE COAST WITH MID 90S TO 105 FOR INLAND AREAS.\n* LOCATION...THE ENTIRE SAN FRANCISCO BAY AREA AND ENTIRE\nMONTEREY BAY AREA.\n* TIMING...HOTTEST DAYS ARE EXPECTED TO BE SUNDAY AND MONDAY.\nMODEST COOLING WILL OCCUR ON TUESDAY...MAINLY NEAR THE COAST.\nMUCH MORE SIGNIFICANT AND WIDESPREAD COOLING IS FORECAST TO\nOCCUR BY WEDNESDAY.\n* IMPACTS...THE HEAT WILL RESULT IN ELEVATED HEALTH RISKS FOR\nTHOSE WHO ARE SENSITIVE TO HEAT.\n", alert.description)
    }
}