//
//  Day.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Day {
    let apparentTemperatureMax: Float?
    let apparentTemperatureMaxTime: Int?
    let apparentTemperatureMin: Float?
    let apparentTemperatureMinTime: Int?
    let icon: String?
    let moonPhase: Float?
    let temperatureMax: Float?
    let temperatureMaxTime: Int?
    let temperatureMin: Float?
    let temperatureMinTime: Int?
    let time: Int?
    let precipIntensity: Float?
    let precipIntensityMax: Float?
    let precipProbability: Float?
    let precipProbabilityMaxTime: Int?
    let sunriseTime: Double?
    let sunsetTime: Double?
    
    init(data:JSONDictionary) {
        self.apparentTemperatureMax = data["apparentTemperatureMax"] as? Float
        self.apparentTemperatureMaxTime = data["apparentTemperatureMaxTime"] as? Int
        self.apparentTemperatureMin = data["apparentTemperatureMin"] as? Float
        self.apparentTemperatureMinTime = data ["apparentTemperatureMinTime"] as? Int
        self.precipIntensity = data["precipIntensity"] as? Float
        self.precipIntensityMax = data["precipIntensityMax"] as? Float
        self.precipProbability = data["precipProbability"] as? Float
        self.precipProbabilityMaxTime = data["precipProbabilityMaxTime"] as? Int
        self.icon = data["icon"] as? String
        self.moonPhase = data["moonPhase"] as? Float
        self.temperatureMax = data["temperatureMax"] as? Float
        self.temperatureMaxTime = data["temperatureMaxTime"] as? Int
        self.temperatureMin = data["temperatureMin"] as? Float
        self.temperatureMinTime = data["temperatureMinTime"] as? Int
        self.time = data["time"] as? Int
        self.sunriseTime = data["sunriseTime"] as? Double
        self.sunsetTime = data["sunsetTime"] as? Double 
    }
}
