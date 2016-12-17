//
//  Alert.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/16/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Curry
import Argo
import Runes

struct Alert {
    let title: String
    let description: String
    let expires: Double
    let uri: String
}

extension Alert: Decodable {
    static func decode(_ json: JSON) -> Decoded<Alert> {
        return curry(Alert.init)
        <^> json <| "title"
        <*> json <| "description"
        <*> json <| "expires"
        <*> json <| "uri"
    }
}
