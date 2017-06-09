//
//  Hours.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Hours {
    let summary:String
    let hours:[Hour]
}

extension Hours: Decodable {
    static func decode(_ json: JSON) -> Decoded<Hours> {
        return curry(Hours.init)
        <^> json <| "summary"
        <*> json <|| "data"
    }
}
