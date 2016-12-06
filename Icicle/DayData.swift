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
    let maxPrecipTime: String
    let precipType: String
    let summary: String
    
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
    
    static let specificTimeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    static func parseTempString(temp:Float, time:Double?) -> String {
        var timeString = "\(Int(temp))°"
        if let timeDouble = time {
            timeString.append(" at \(timeformatter.string(from: Date(timeIntervalSince1970: timeDouble)))")
        }
        return timeString
    }
    
    static func create(_ decodedDay:Decoded<Day>, timeZone:TimeZone) -> Result<String, DayData> {
        guard let day = decodedDay.value else {
            if let error = decodedDay.error {
                return .error(error.description)
            } else {
                return .error("Unknown Error")
            }
        }
        
        dateformatter.timeZone = timeZone
        timeformatter.timeZone = timeZone
        specificTimeformatter.timeZone = timeZone
        
        let date = self.dateformatter.string(from: Date(timeIntervalSince1970: day.time))
        let high = parseTempString(temp: day.temperatures.temperatureMax, time: day.temperatures.temperatureMaxTime)
        let low = parseTempString(temp: day.temperatures.temperatureMin, time: day.temperatures.temperatureMinTime)
        let sunrise = day.sunriseTime != nil ? specificTimeformatter.string(from: Date(timeIntervalSince1970: day.sunriseTime!)) : "Unknown"
        let sunset = day.sunsetTime != nil ? specificTimeformatter.string(from: Date(timeIntervalSince1970: day.sunsetTime!)) : "Unknown"
        let precipType = formatPrecipType(day.precipType)
        let precipChance = formatPrecipChance(day.precipProbability)

        let maxPrecipTime: String
        switch day.precipIntensityMaxTime {
        case .none: maxPrecipTime = "—"
        case .some(let value): maxPrecipTime = timeformatter.string(from: Date(timeIntervalSince1970: value))
        }
        
        return .success(DayData(date: date, high: high, low: low, sunrise: sunrise, sunset: sunset, precipChance: precipChance,
                                maxPrecipTime: maxPrecipTime, precipType: precipType, summary: day.summary))
    }
}

extension DayData: HasPrecipitation { }
