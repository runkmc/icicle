//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:Data, granularity:TimeGranularity) throws -> JSONDictionary {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
        return json[granularity.rawValue] as! JSONDictionary
    }
    catch {
        throw error as NSError
    }
}
