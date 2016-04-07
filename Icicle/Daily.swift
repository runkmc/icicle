//
//  Daily.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/7/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Daily {
    let icon: String
    let summary: String
}

extension Daily: Decodable {
    static func decode(j:JSON) -> Decoded<Daily> {
        let f = curry(Daily.init)
        return f
            <^> j <| "icon"
            <*> j <| "summary"
    }
}