//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:Data, granularity:TimeGranularity) -> [String: AnyObject] {
    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
    guard let item = json??[granularity.rawValue] else {
        return [String: AnyObject]()
    }
    return item as! [String : AnyObject]
}
