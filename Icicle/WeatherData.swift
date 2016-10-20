//
//  WeatherData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/15/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

struct WeatherData {
    
    let fullSummary:String
    
    init(fullSummary:String) {
        self.fullSummary = fullSummary
    }
    
    static func create(models:WeatherModels) -> Result<String, WeatherData> {
        let fullSummary = parseSummary(models)
        return .success(WeatherData(fullSummary: fullSummary))
    }
    
    private static func parseSummary(_ models:WeatherModels) -> String {
        let temp = Int(models.currently.temperature)
        let currentTemp = "\(temp)°"
        
        var feelsTemp = "."
        if let feelsLike = models.currently.apparentTemperature,
            !((temp - 1)..<(temp + 1)).contains(Int(feelsLike)) {
            feelsTemp = ", but feels like \(Int(feelsLike))°."
        }
        
        var tomorrow = ""
        if models.days.days.indices.contains(1) {
            tomorrow = "Tomorrow, \(models.days.days[1].summary.lowercased())"
            tomorrow.remove(at: tomorrow.index(before: tomorrow.endIndex))
            tomorrow.append(", high of \(Int(models.days.days[1].temperatures.temperatureMax))°.")
        }
        
        return "Currently \(currentTemp)\(feelsTemp) \(models.minutes.summary) \(models.hours.summary) \(tomorrow) \(models.days.summary)"
    }
    
}
