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

struct Minutes {
    let summary: String
    let minutes: [Minute]
}

extension Minutes: Decodable {
    static func decode(_ json: JSON) -> Decoded<Minutes> {
        return curry(Minutes.init)
        <^> json <| "summary"
        <*> json <|| "data"
    }
}
