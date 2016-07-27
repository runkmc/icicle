//
//  Minutley.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/27/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Minutley {
    let minutes: [Minute?]
    let icon: String
    let summary: String
    
    init?(data:[String:AnyObject]) {
        if let icon = data["icon"] as? String,
        summary = data["summary"] as? String,
        minutes = data["data"] as? [[String:AnyObject]] {
            self.icon = icon
            self.summary = summary
            self.minutes = minutes.map { Minute(data: $0) }
        } else {
            return nil
        }
    }
}
