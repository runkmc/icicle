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
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M/d"
        return formatter
    }()
    
    let date: String
    
    static func create(decodedDay:Decoded<Day>) -> Result<[String], DayData> {
        guard let day = decodedDay.value else {
            return .error(["oops"])
        }
        let date = self.formatter.string(from: Date(timeIntervalSince1970: day.time))
        return .success(DayData(date: date))
    }
}
