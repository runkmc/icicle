//
//  Days.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/30/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Days {
    let icon:String?
    let summary:String?
    let days:[Day]?
}

extension Days: Decodable {
    static func decode(_ json: JSON) -> Decoded<Days> {
        return curry(Days.init)
        <^> json <|? "icon"
        <*> json <|? "summary"
        <*> json <||? "data"
    }
}
