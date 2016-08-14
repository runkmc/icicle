//
//  getTestJson.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
@testable import Icicle

func getTestJSON(named:String, forClass:XCTestCase.Type) -> Data {
    let bundle = Bundle(for: forClass)
    let path = bundle.url(forResource: named, withExtension: "json")
    let data = try! Data(contentsOf: path!)
    return data

}
