//
//  Day.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Day {
    let time:Double
    let summary:String
    let temperatures:Temperature
    }

extension Day: Decodable {
    static func decode(_ json: JSON) -> Decoded<Day> {
        return curry(Day.init)
        <^> json <| "time"
        <*> json <| "summary"
        <*> Temperature.decode(json)
    }
}
