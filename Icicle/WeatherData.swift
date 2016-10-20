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
    let locationName:String
    let weatherColor:UIColor
    
    init(fullSummary:String, locationName:String, color:UIColor) {
        self.fullSummary = fullSummary
        self.locationName = locationName
        self.weatherColor = color
    }
    
    static func create(models:WeatherModels, location:Location) -> Result<String, WeatherData> {
        let fullSummary = parseSummary(models)
        let color = parseColor(icon: models.currently.icon)
        
        return .success(WeatherData(fullSummary: fullSummary,
                                    locationName: location.name,
                                    color: color))
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
    
    private static func parseColor(icon:String) -> UIColor {
        switch icon {
            case "clear-day"             : return IcicleColor.orange
            case "clear-night"           : return IcicleColor.violet
            case "partly-cloudy-night"   : return IcicleColor.base02
            case "rain", "sleet"         : return IcicleColor.blue
            case "snow", "fog", "cloudy" : return IcicleColor.cyan
            case "wind"                  : return IcicleColor.red
            case "partly-cloudy-day"     : return IcicleColor.green
        default                          : return IcicleColor.magenta
        }
        
    }
    
}
