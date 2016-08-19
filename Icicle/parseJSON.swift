//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:Data, granularity:TimeGranularity) throws -> JSON {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSON
        return json[granularity.rawValue] as! JSON
    }
    catch {
        throw error as NSError
    }
}
