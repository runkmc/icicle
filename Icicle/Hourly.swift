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
}

extension Hourly: Decodable {
    static func decode(j:JSON) -> Decoded<Hourly> {
        return curry(Hourly.init)
            <^> j <| "icon"
            <*> j <| "summary"
    }
}