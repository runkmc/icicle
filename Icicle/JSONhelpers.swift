//
//  parseJSON.swift
//  Icicle
//
//  Created by Kevin McGladdery on 4/6/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func parseJSON(data:Data, granularity:String) -> Result<NSError, [String:Any]> {
    let json: [String:Any]
    do {
        json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
    } catch let error as NSError {
        return .error(error)
    }
    return .success(json)
}

func timeParser(data:Data, granularity:TimeGranularity) -> Result<NSError, [String:Any]> {
    let result = parseJSON(data: data, granularity: granularity.rawValue)
    switch result {
    case .error(let e): return .error(e)
    case .success(let s):
        if let json = s[granularity.rawValue] as? [String:Any] {
            return .success(json)
        } else {
            return .error(NSError(domain: "\(granularity.rawValue) data not found", code: 1, userInfo: nil))
        }
    }
}

func alertParser(data:Data) -> Result<NSError, [Any]> {
    let result = parseJSON(data: data, granularity:"alerts")
    switch result {
    case .error(let e): return .error(e)
    case .success(let s):
        if let json = s["alerts"] as? [Any] {
            return .success(json)
        } else {
            return .error(NSError(domain: "Alert data not found", code: 1, userInfo: nil))
        }
    }
}

func timeZoneParser(data:Data) -> Result<NSError, TimeZone> {
    let result = parseJSON(data:data, granularity:"timezone")
    switch result {
    case .error(let e): return .error(e)
    case .success(let s):
        if let timeZoneString = s["timezone"] as? String, let timeZone = TimeZone(identifier: timeZoneString) {
            return .success(timeZone)
        } else {
            return .error(NSError(domain:"Timezone not valid", code: 1, userInfo: nil))
        }
    }
}
