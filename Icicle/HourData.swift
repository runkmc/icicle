//
//  HourData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/3/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

struct HourData {
    let time: String
    let summary: String
    let temperature: String
    let precipChance: String
    let precipType: String
    let apparentTemperature: String
    let humidity: String
    
    static let timeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "h a"
        return formatter
    }()
    
    static func parseTemp(_ temp:Float?) -> String {
        if let t = temp {
            return "\(Int(t))°"
        } else {
            return "Unknown"
        }
    }
    
    static func create(_ decodedHour:Decoded<Hour>, timeZone:TimeZone) -> Result<String, HourData> {
        guard let hour = decodedHour.value else {
            if let error = decodedHour.error {
                return .error(error.description)
            } else {
                return .error("Unknown Error")
            }
        }
        timeformatter.timeZone = timeZone
        
        let time = timeformatter.string(from: Date(timeIntervalSince1970: hour.time))
        let temperature = parseTemp(hour.temperature)
        let precipChance = formatPercentage(hour.precipProbability)
        let precipType = formatPrecipType(hour.precipType)
        let apparentTemperature = parseTemp(hour.apparentTemperature)
        let humidity = formatPercentage(hour.humidity)
        
        return .success(HourData(time: time, summary: hour.summary, temperature: temperature, precipChance: precipChance,
                                 precipType: precipType, apparentTemperature: apparentTemperature, humidity: humidity))
    }
}

extension HourData: HasPrecipitation { }
