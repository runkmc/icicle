//
//  Hour.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Hour {
    let apparentTemperature: Double
    let cloudCover: Double
    let humidity: Double
    let icon: String
    let precipIntensity: Double
    let precipProbability: Double
    let summary: String
    let temperature: Double
    let time: Int
}

extension Hour: Decodable {
    static func decode(j:JSON) -> Decoded<Hour> {
        return curry(Hour.init)
            <^> j <| "apparentTemperature"
            <*> j <| "cloudCover"
            <*> j <| "humidity"
            <*> j <| "icon"
            <*> j <| "precipIntensity"
            <*> j <| "precipProbability"
            <*> j <| "summary"
            <*> j <| "temperature"
            <*> j <| "time"
    }
}