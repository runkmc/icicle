//
//  Minutley.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Minute {
    let precipIntensity: Float
    let precipProbability: Float
    let time: Int
    
    init?(data:JSON) {
        if let intensity = data["precipIntensity"] as? Float,
        probability = data["precipProbability"] as? Float,
        time = data["time"] as? Int {
            self.precipIntensity = intensity
            self.precipProbability = probability
            self.time = time
        } else {
            return nil
        }
    }
}
