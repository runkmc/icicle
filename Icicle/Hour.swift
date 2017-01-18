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
    let summary: String
    let icon:String
    let precipProbability:Float?
    let precipType:String?
    let temperature:Float?
    let apparentTemperature:Float?
    let humidity:Float?
}

extension Hour: Decodable {
    static func decode(_ json: JSON) -> Decoded<Hour> {
        return curry(Hour.init)
        <^> json <|  "time"
        <*> json <|  "summary"
        <*> json <| "icon"
        <*> json <|? "precipProbability"
        <*> json <|? "precipType"
        <*> json <|? "temperature"
        <*> json <|? "apparentTemperature"
        <*> json <|? "humidity"
    }
}
