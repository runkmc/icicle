//
//  Daily.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/14/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Days {
    let icon: String?
    let summary: String?
    let days: [Day]
    
    init(data:JSONDictionary) {
        self.icon = data["icon"] as? String
        self.summary = data["summary"] as? String
		if let days = data["data"] as? [JSONDictionary] {
			self.days = days.map { Day(data:$0) }
        } else {
			self.days = []
        }
    }
}

