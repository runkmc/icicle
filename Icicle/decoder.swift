//
//  decoder.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/17/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

func decoder(data:Data) -> Result<[String], WeatherModels> {
    var errors: [String] = []
    
    let currentlyJSON = timeParser(data: data, granularity: .current)
    let minutesJSON = timeParser(data: data, granularity: .minute)
    let hoursJSON = timeParser(data: data, granularity: .hour)
    let daysJSON = timeParser(data: data, granularity: .day)
    let badJson = Result.errors([currentlyJSON, minutesJSON, hoursJSON, daysJSON])
    if badJson.count > 0 {
        badJson.forEach { error in
            errors.append(error.errorValue()!.domain)
            }
        return .error(errors)
    }
    let currently: Decoded<Currently> = decode(currentlyJSON.successValue()!)
    let minutes: Decoded<Minutes> = decode(minutesJSON.successValue()!)
    let hours: Decoded<Hours> = decode(hoursJSON.successValue()!)
    let days: Decoded<Days> = decode(daysJSON.successValue()!)

    let alertsJSON = alertParser(data: data)
    var alerts: [Alert] = []
    if Result.isSuccess(alertsJSON) {
        alerts = alertsJSON.successValue()!.map{ a -> Alert? in decode(a) }.flatMap{$0}
    }
    
    let timeZoneJSON = timeZoneParser(data: data)
    var timeZone: TimeZone
    if Result.isSuccess(timeZoneJSON) {
        timeZone = timeZoneJSON.successValue()!
    } else {
        return .error([timeZoneJSON.errorValue()!.description])
    }
    
    return .success(WeatherModels(currently:currently, minutes:minutes, hours:hours, days:days, alerts:alerts, timeZone:timeZone))
}
