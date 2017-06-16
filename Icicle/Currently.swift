//
//  Currently.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/8/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Currently {
    let time:Double
    let summary:String
    let temperature:Float
    let apparentTemperature:Float?
    let precipProbability:Float?
    let precipType:String?
}

extension Currently: Decodable {
    static func decode(_ json: JSON) -> Decoded<Currently> {
        return curry(Currently.init)
        <^> json <| "time"
        <*> json <| "summary"
        <*> json <| "temperature"
        <*> json <|? "apparentTemperature"
        <*> json <|? "precipProbability"
        <*> json <|? "precipType"
    }
}
