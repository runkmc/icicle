//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:Data, granularity:TimeGranularity) -> Result<NSError, [String:Any]> {
    let json: [String:Any]
    do {
        json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
    } catch let error as NSError {
        return .error(error)
    }
    
    if let data = json[granularity.rawValue] as? [String:Any] {
        return .success(data)
    } else {
        return .error(NSError(domain: "\(granularity.rawValue) data not found", code: 1, userInfo: nil))
    }
}
