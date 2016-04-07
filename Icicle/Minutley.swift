//
//  Minutley.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Minutely {
    let icon: String
    let summary: String
}

extension Minutely: Decodable {
    static func decode(j:JSON) -> Decoded<Minutely> {
        return curry(Minutely.init)
            <^> j <| "icon"
            <*> j <| "summary"
    }
}