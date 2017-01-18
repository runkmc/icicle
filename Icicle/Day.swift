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
    let icon:String
    let sunriseTime:Double?
    let sunsetTime:Double?
    let moonPhase:Double?
    let precipIntensity:Float?
    let precipIntensityMaxTime:Double?
    let precipProbability:Float?
    let precipType:String?
    let temperatures:Temperature
    }

extension Day: Decodable {
    static func decode(_ json: JSON) -> Decoded<Day> {
        return curry(Day.init)
        <^> json <| "time"
        <*> json <| "summary"
        <*> json <| "icon"
		<*> json <|? "sunriseTime"
		<*> json <|? "sunsetTime"
		<*> json <|? "moonPhase"
		<*> json <|? "precipIntensity"
		<*> json <|? "precipIntensityMaxTime"
		<*> json <|? "precipProbability"
		<*> json <|? "precipType"
        <*> Temperature.decode(json)
    }
}
