//
//  WeatherData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/15/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit
import Argo

struct WeatherData {
    
    let fullSummary:String
    let hours:[HourData]
    let days:[DayData]
    let alerts:[AlertData]
    let location: Location
    
    init(fullSummary:String, hours:[HourData], days:[DayData], alerts:[AlertData], location:Location) {
        self.fullSummary = fullSummary
        self.hours = hours
        self.days = days
        self.alerts = alerts
        self.location = location
    }
    
    static func create(models:WeatherModels, location:Location) -> Result<String, WeatherData> {
        guard let currently = models.currently.value else { return .error(models.currently.error!.description) }
        guard let minutes = models.minutes.value else { return .error(models.minutes.error!.description) }
        guard let hours = models.hours.value else { return .error(models.hours.error!.description) }
        guard let days = models.days.value else { return .error(models.days.error!.description) }
        
        let fullSummary = parseSummary(currently:currently, minutes:minutes, hours:hours, days:days)
        let individualHours = hours.hours.map { HourData.create($0, timeZone:models.timeZone) }
        let individualDays = days.days.map { DayData.create($0, timeZone:models.timeZone) }
        let alerts = models.alerts.map { AlertData.create($0) }
        
        return .success(WeatherData(fullSummary: fullSummary,
                                    hours:individualHours,
                                    days:individualDays,
                                    alerts:alerts,
                                    location:location))
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
}
