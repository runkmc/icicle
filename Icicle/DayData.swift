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
    
    static func parseTempString(temp:Float, time:Double?) -> String {
        var timeString = "\(Int(temp))°"
        if let timeDouble = time {
            timeString.append(" at \(timeformatter.string(from: Date(timeIntervalSince1970: timeDouble)))")
        }
        return timeString
    }
    
    static func create(_ day:Day, timeZone:TimeZone) -> DayData {
        
        dateformatter.timeZone = timeZone
        timeformatter.timeZone = timeZone
        
        let date = self.dateformatter.string(from: Date(timeIntervalSince1970: day.time))
        let high = parseTempString(temp: day.temperatures.temperatureMax, time: day.temperatures.temperatureMaxTime)
        let low = parseTempString(temp: day.temperatures.temperatureMin, time: day.temperatures.temperatureMinTime)
        return DayData(date: date, high: high, low: low, summary: day.summary)
    }
}
