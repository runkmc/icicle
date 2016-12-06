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
    static func formatPrecipChance(_ chance:Float?) -> String
}

extension HasPrecipitation {
    static func formatPrecipChance(_ chance:Float?) -> String {
        switch chance {
        case .none: return "None"
        case .some(let value) where value == 0: return "None"
        case .some(let value): return String(format: "%.0f%%", (value * 100))
        }
    }
}
