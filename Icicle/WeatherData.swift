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
    let hours:[HourData]
    let days:[DayData]
    let alerts:[AlertData]
    
    init(fullSummary:String, locationName:String, color:UIColor, hours:[HourData], days:[DayData], alerts:[AlertData]) {
        self.fullSummary = fullSummary
        self.locationName = locationName
        self.weatherColor = color
        self.hours = hours
        self.days = days
        self.alerts = alerts
    }
    
    static func create(models:WeatherModels, location:Location) -> Result<String, WeatherData> {
        guard let currently = models.currently.value else { return .error(models.currently.error!.description) }
        guard let minutes = models.minutes.value else { return .error(models.minutes.error!.description) }
        guard let hours = models.hours.value else { return .error(models.hours.error!.description) }
        guard let days = models.days.value else { return .error(models.days.error!.description) }
        
        let fullSummary = parseSummary(currently:currently, minutes:minutes, hours:hours, days:days)
        let color = parseColor(icon: currently.icon)
        let individualHours = hours.hours.map { HourData.create($0, timeZone:models.timeZone) }
        let individualDays = days.days.map { DayData.create($0, timeZone:models.timeZone) }
        let alerts = models.alerts.map { AlertData.create($0) }
        
        return .success(WeatherData(fullSummary: fullSummary,
                                    locationName: location.name,
                                    color: color,
                                    hours:individualHours,
                                    days:individualDays,
                                    alerts:alerts))
    }
    
    private static func parseSummary(currently:Currently, minutes:Minutes, hours:Hours, days:Days) -> String {
        let temp = Int(currently.temperature)
        let currentTemp = "\(temp)°"
        
        var feelsTemp = "."
        if let feelsLike = currently.apparentTemperature,
            !((temp - 1)..<(temp + 1)).contains(Int(feelsLike)) {
            feelsTemp = ", but feels like \(Int(feelsLike))°."
        }
        
        var tomorrow = ""
        if days.days.indices.contains(1) {
            tomorrow = "Tomorrow, \(days.days[1].summary.lowercased())"
            tomorrow.remove(at: tomorrow.index(before: tomorrow.endIndex))
            tomorrow.append(", high of \(Int(days.days[1].temperatures.temperatureMax))°.")
        }
        
        return "Currently \(currentTemp)\(feelsTemp) \(minutes.summary) \(hours.summary) \(tomorrow) \(days.summary)"
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
