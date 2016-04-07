//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

func parseJSON(data:NSData, granularity:TimeGranularity) -> AnyObject {
    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
    guard let item = json??[granularity.rawValue] else {
        return [String: AnyObject]()
    }
    return item
}