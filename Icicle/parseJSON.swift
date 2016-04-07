//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:NSData, granularity:TimeGranularity) -> [String: AnyObject] {
    let potentialJSON = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
    guard let json = potentialJSON else {
        return [:]
    }
    return json[granularity.rawValue]
}