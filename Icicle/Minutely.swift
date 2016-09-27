//
//  Minutley.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/26/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Minutely {
    let summary: String
    let minutes: [Minute]
}

extension Minutely: Decodable {
    static func decode(_ json: JSON) -> Decoded<Minutely> {
        return curry(Minutely.init)
        <^> json <| "summary"
        <*> json <|| "data"
    }
}
