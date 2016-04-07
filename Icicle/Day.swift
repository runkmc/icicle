//
//  Day.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/7/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Day {
    let icon: String
    let moonPhase: Double
    let precipIntensity: Double
    let precipIntensityMax: Double
    let precipProbability: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let temperatureMin: Double
    let temperatureMinTime: Int
    let time: Int
}

extension Day: Decodable {
    static func decode(j:JSON) -> Decoded<Day> {
        let f = curry(Day.init)
        return f
            <^> j <| "icon"
            <*> j <| "moonPhase"
            <*> j <| "precipIntensity"
            <*> j <| "precipIntensityMax"
            <*> j <| "precipProbability"
            <*> j <| "sunriseTime"
            <*> j <| "sunsetTime"
            <*> j <| "temperatureMax"
            <*> j <| "temperatureMaxTime"
            <*> j <| "temperatureMin"
            <*> j <| "temperatureMinTime"
            <*> j <| "time"
    }
}
