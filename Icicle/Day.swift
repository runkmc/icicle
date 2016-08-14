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
    let icon: String
    let moonPhase: Float
    let temperatureMax: Float
    let temperatureMaxTime: Int
    let temperatureMin: Float
    let temperatureMinTime: Int
    let time: Int
    let precipIntensity: Float?
    let precipIntensityMax: Float?
    let precipProbability: Float?
    let precipProbabilityMaxTime: Int?
    let sunriseTime: Int
    let sunsetTime: Int
    
    init?(data:JSON) {
        self.apparentTemperatureMax = data["apparentTemperatureMax"] as? Float
        self.apparentTemperatureMaxTime = data["apparentTemperatureMaxTime"] as? Int
        self.apparentTemperatureMin = data["apparentTemperatureMin"] as? Float
        self.apparentTemperatureMinTime = data ["apparentTemperatureMinTime"] as? Int
        self.precipIntensity = data["precipIntensity"] as? Float
        self.precipIntensityMax = data["precipIntensityMax"] as? Float
        self.precipProbability = data["precipProbability"] as? Float
        self.precipProbabilityMaxTime = data["precipProbabilityMaxTime"] as? Int
        
        if let icon = data["icon"] as? String,
        let moonPhase = data["moonPhase"] as? Float,
        let temperatureMax = data["temperatureMax"] as? Float,
        let temperatureMaxTime = data["temperatureMaxTime"] as? Int,
        let temperatureMin = data["temperatureMin"] as? Float,
        let temperatureMinTime = data["temperatureMinTime"] as? Int,
        let time = data["time"] as? Int,
        let sunriseTime = data["sunriseTime"] as? Int,
        let sunsetTime = data["sunsetTime"] as? Int {
            self.moonPhase = moonPhase
            self.icon = icon
            self.temperatureMax = temperatureMax
            self.temperatureMaxTime = temperatureMaxTime
            self.temperatureMin = temperatureMin
            self.temperatureMinTime = temperatureMinTime
            self.time = time
            self.sunriseTime = sunriseTime
            self.sunsetTime = sunsetTime
        } else {
            return nil
        }
        
    }
}
