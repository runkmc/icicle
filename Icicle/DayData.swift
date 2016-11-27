//
//  DayData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 11/20/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

struct DayData {
    let date: String
    let high: String
    let low: String
    let sunrise: String
    let sunset: String
    let precipChance: String
    
    static let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    static let timeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "ha"
        return formatter
    }()
    
    static let specificTimeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    static func create(_ decodedDay:Decoded<Day>, timeZone:TimeZone) -> Result<[String], DayData> {
        guard let day = decodedDay.value else {
            return .error(["oops"])
        }
        dateformatter.timeZone = timeZone
        timeformatter.timeZone = timeZone
        specificTimeformatter.timeZone = timeZone
        
        let date = self.dateformatter.string(from: Date(timeIntervalSince1970: day.time))
        let high = parseTempString(temp: day.temperatures.temperatureMax, time: day.temperatures.temperatureMaxTime)
        let low = parseTempString(temp: day.temperatures.temperatureMin, time: day.temperatures.temperatureMinTime)
        let sunrise = day.sunriseTime != nil ? specificTimeformatter.string(from: Date(timeIntervalSince1970: day.sunriseTime!)) : "Unknown"
        let sunset = day.sunsetTime != nil ? specificTimeformatter.string(from: Date(timeIntervalSince1970: day.sunsetTime!)) : "Unknown"
        let precipChance: String
        switch day.precipProbability {
        case .none: precipChance = "None"
        case .some(let value) where value == 0: precipChance = "None"
        case .some(let value): precipChance = String(format: "%.0f%%", (value * 100))
        }

        return .success(DayData(date: date, high: high, low: low, sunrise: sunrise, sunset: sunset, precipChance: precipChance))
    }
    
    static func parseTempString(temp:Float, time:Double?) -> String {
        var timeString = "\(Int(temp))°"
        if let timeDouble = time {
            timeString.append(" at \(timeformatter.string(from: Date(timeIntervalSince1970: timeDouble)))")
        }
        return timeString
    }
}
