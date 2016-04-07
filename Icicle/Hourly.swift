//
//  Hourly.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Hourly {
    let icon: String
    let summary: String
    let data: [Hour]
}

extension Hourly: Decodable {
    static func decode(j:JSON) -> Decoded<Hourly> {
        let f = curry(Hourly.init)
            return f
            <^> j <| "icon"
            <*> j <| "summary"
            <*> j <|| "data"
    }
}