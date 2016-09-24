//
//  Minutley.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Minute {
    let precipIntensity: Float?
    let precipProbability: Float?
    let time: Double?
    
    init(data:JSONDictionary) {
        self.precipIntensity = data["precipIntensity"] as? Float
        self.precipProbability = data["precipProbability"] as? Float
        self.time = data["time"] as? Double
    }
}
