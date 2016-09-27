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

struct Minutley {
    let summary: String
    let minutes: [Minute]?
}

extension Minutley: Decodable {
    static func decode(_ json: JSON) -> Decoded<Minutley> {
        return curry(Minutley.init)
        <^> json <| "summary"
        <*> json <||? "data"
    }
}
