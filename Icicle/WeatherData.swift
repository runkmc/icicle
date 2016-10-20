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
        let currentTemp = "\(Int(models.currently.temperature))°"
        var feelsTemp = "."
        if let feelsLike = models.currently.apparentTemperature {
            feelsTemp = ", but feels like \(Int(feelsLike))°."
        }
        
        return "Currently \(currentTemp)\(feelsTemp) \(models.minutes.summary) \(models.hours.summary) \(models.days.summary)"
    }
    
}
