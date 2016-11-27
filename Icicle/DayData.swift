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
        
        let date = self.dateformatter.string(from: Date(timeIntervalSince1970: day.time))
        let high = parseTempString(temp: day.temperatures.temperatureMax, time: day.temperatures.temperatureMaxTime)
        let low = parseTempString(temp: day.temperatures.temperatureMin, time: day.temperatures.temperatureMinTime)
        var sunrise = "Unknown"
        if let sunriseTime = day.sunriseTime {
            sunrise = specificTimeformatter.string(from: Date(timeIntervalSince1970: sunriseTime))
        }
        var sunset = "Unknown"
        if let sunsetTime = day.sunsetTime {
            sunset = specificTimeformatter.string(from: Date(timeIntervalSince1970: sunsetTime))
        }
        
        return .success(DayData(date: date, high: high, low: low, sunrise: sunrise, sunset: sunset))
    }
    
    static func parseTempString(temp:Float, time:Double?) -> String {
        var timeString = "\(Int(temp))°"
        if let timeDouble = time {
            timeString.append(" at \(timeformatter.string(from: Date(timeIntervalSince1970: timeDouble)))")
        }
        return timeString
    }
}
