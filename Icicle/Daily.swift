//
//  Daily.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Daily {
    let icon: String
    let summary: String
    let days: [Day?]
    
    init?(data:JSON) {
        if let icon = data["icon"] as? String,
        let summary = data["summary"] as? String,
            let days = data["data"] as? [JSON] {
            self.icon = icon
            self.summary = summary
            self.days = days.map { Day(data:$0) }
        } else {
            return nil
        }
    }
}

