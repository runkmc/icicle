//
//  HasPrecipitation.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/5/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

protocol HasPrecipitation {
    var precipChance: String { get }
    var precipType: String { get }
    static func formatPercentage(_ chance:Float?) -> String
    static func formatPrecipType(_ type:String?) -> String
}

extension HasPrecipitation {
    static func formatPercentage(_ chance:Float?) -> String {
        switch chance {
        case .none: return "0%"
        case .some(let value): return String(format: "%.0f%%", (value * 100))
        }
    }
    
    static func formatPrecipType(_ type:String?) -> String {
        return type != nil ? type!.capitalized : "—"
    }
}
