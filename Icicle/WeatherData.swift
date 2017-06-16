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
    let headline:String
    let hours:[HourData]
    let days:[DayData]
    let alerts:[AlertData]
    let location: Location
    let date: String
    let time: String
    
    static let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    static let timeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h a"
        return formatter
    }()
    
    init(fullSummary:String, headline:String, hours:[HourData], days:[DayData], alerts:[AlertData], location:Location) {
        self.fullSummary = fullSummary
        self.headline = headline
        self.hours = hours
        self.days = days
        self.alerts = alerts
        self.location = location
        self.date = WeatherData.dateformatter.string(from: Date())
        self.time = WeatherData.timeformatter.string(from: Date())
    }
    
    static func create(models:WeatherModels, location:Location) -> Result<String, WeatherData> {
        guard let currently = models.currently.value else { return .error(models.currently.error!.description) }
        guard let minutes = models.minutes.value else { return .error(models.minutes.error!.description) }
        guard let hours = models.hours.value else { return .error(models.hours.error!.description) }
        guard let days = models.days.value else { return .error(models.days.error!.description) }
        
        let fullSummary = parseSummary(currently:currently, minutes:minutes, hours:hours, days:days)
        let headline = "\(currently.summary)/\(Int(currently.temperature))°"
        let individualHours = hours.hours.map { HourData.create($0, timeZone:models.timeZone) }
        let individualDays = days.days.map { DayData.create($0, timeZone:models.timeZone) }
        let alerts = models.alerts.map { AlertData.create($0) }
        
        return .success(WeatherData(fullSummary: fullSummary,
                                    headline:headline,
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
