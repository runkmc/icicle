//
//  Hour.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Hour {
    let time:Double
    let icon:String?
    let precipIntensity:Float?
    let precipProbability:Float?
    let precipType:String?
    let precipAccumulation:Float?
    let temperature:Float?
    let apparentTemperature:Float?
    let humidity:Float?
}

extension Hour: Decodable {
    static func decode(_ json: JSON) -> Decoded<Hour> {
        return curry(Hour.init)
        <^> json <|  "time"
        <*> json <|? "icon"
        <*> json <|? "precipIntensity"
        <*> json <|? "precipProbability"
        <*> json <|? "precipType"
        <*> json <|? "precipAccumulation"
        <*> json <|? "temperature"
        <*> json <|? "apparentTemperature"
        <*> json <|? "humidity"
    }
}
