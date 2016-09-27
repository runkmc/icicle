//
//  Minute.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/25/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Minute {
    let precipIntensity: Float?
    let precipProbability: Float?
    let time: Double
}

extension Minute: Decodable {
    static func decode(_ json:JSON) -> Decoded<Minute> {
        return curry(Minute.init)
        <^> json <|? "precipIntensity"
        <*> json <|? "precipProbability"
        <*> json <|  "time"
    }
}
