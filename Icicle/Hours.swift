//
//  Hourly.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/5/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Hours {
	let hours: [Hour]
	let icon: String?
	let summary: String?

	init(data:JSON) {
		self.icon = data["icon"] as? String
		self.summary = data["summary"] as? String
		if let hours = data["data"] as? [JSONDictionary] {
			self.hours = hours.map { Hour(data:$0) }
		} else {
			self.hours = []
		}
	}
}
