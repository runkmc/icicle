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
    let points: [String]
    let highLabel: String
    let lowLabel: String
    
    init?(currently:Currently, hours:Hours) {
        guard let temp = currently.temperature else {
            return nil
        }
        
        let temps: [Float] = hours.hours.prefix(24).flatMap { $0.temperature?.rounded(.toNearestOrAwayFromZero) }
        guard temps.count > 2 else {
            return nil
        }
        
        self.currentDataPoint = "\(Int(temp))°"
        self.color = IcicleColor.green
        self.high = Int(temps.max()!)
        self.low = Int(temps.min()!)
        self.points = temps.map { String($0) }
        self.highLabel = "\(self.high)°"
        self.lowLabel = "\(self.low)°"
    }
}
