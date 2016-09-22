//
//  TemperatureGraphData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

struct TemperatureGraphData: GraphData {
    
    let title = "Temperature"
    let currentDataPoint: String
    let color: UIColor
    let high: Int
    let low: Int
    let highLabel: String
    let points: [DataPoint]
    let lowLabel: String
    let xAxisLabels: [String]
    
        
    init?(currently:Currently, hours:Hours, timezone:TimeZone) {
        let temps: [Float] = hours.hours.prefix(24).flatMap { $0.temperature?.rounded(.toNearestOrAwayFromZero) }
        let rawTimes: [Date] = hours.hours.prefix(24).flatMap({$0.time }).map { Date(timeIntervalSince1970: $0) }
        let hourFormatter = DateFormatter()
        hourFormatter.setLocalizedDateFormatFromTemplate("h")
        hourFormatter.timeZone = timezone
        let times: [String] = rawTimes.map { hour in
            var t = hourFormatter.string(from: hour)
            let spaceIndex = t.index(t.endIndex, offsetBy: -3)
            t.removeSubrange(spaceIndex..<t.endIndex)
            return t
        }
        
        guard temps.count > 2 else { return nil }
        guard temps.count == times.count else { return nil }
        
        var points: [DataPoint] = []
        for i in 0..<temps.count {
            points.append(DataPoint(point: Int(temps[i]), label: times[i]))
        }
        
        self.init(currently:currently, points:points)
    }
    
    // init?(currently:Currently, days:Days, timezone:TimeZone) {
    //     let temps: [Float] = days.days.prefix(7).flatMap { $0.temperature?.rounded(.toNearestOrAwayFromZero) }

    // }
    
    private init?(currently:Currently, points:[DataPoint]) {
        guard let temp = currently.temperature else {
            return nil
        }
        
        self.points = points
        self.currentDataPoint = "\(Int(temp))°"
        self.color = IcicleColor.green
        let temps = points.map { $0.point }
        self.high = Int(temps.max()!)
        self.low = Int(temps.min()!)
        self.highLabel = "\(self.high)°"
        self.lowLabel = "\(self.low)°"
        self.xAxisLabels = points.map { $0.label }
    }

}
