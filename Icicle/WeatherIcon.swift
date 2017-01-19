//
//  WeatherIcon.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/17/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation

enum WeatherIcon {
    case clearDay
    case clearNight
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay
    case partlyCloudyNight
    case unknown
    
    static func create(str:String) -> WeatherIcon {
    switch str {
        case "clear-day": return .clearDay
        case "clear-night": return .clearNight
        case "rain": return .rain
        case "snow": return .snow
        case "sleet": return .sleet
        case "wind": return .wind
        case "fog": return .fog
        case "cloudy": return .cloudy
        case "partly-cloudy-day": return .partlyCloudyDay
        case "partly-cloudy-night": return .partlyCloudyNight
        default: return .unknown
        }
    }
}
