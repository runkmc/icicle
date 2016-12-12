//
//  Temperature.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/29/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Temperature {
    let temperatureMin:Float
    let temperatureMinTime:Double?
    let temperatureMax:Float
    let temperatureMaxTime:Double?
}

extension Temperature: Decodable {
    static func decode(_ json: JSON) -> Decoded<Temperature> {
        return curry(Temperature.init)
        <^> json <| "temperatureMin"
        <*> json <|? "temperatureMinTime"
        <*> json <| "temperatureMax"
        <*> json <|? "temperatureMaxTime"
    }
}
