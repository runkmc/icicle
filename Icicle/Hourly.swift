//
//  Hourly.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/5/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Hourly {
	let hours: [Hour?]
	let icon: String
	let summary: String

	init?(data:JSON) {
		if let icon = data["icon"] as? String,
		let summary = data["summary"] as? String,
		let hours = data["data"] as? [JSON] {
			self.icon = icon
			self.summary = summary
			self.hours = hours.map { Hour(data:$0) }
		} else {
			return nil
		}
	}
}
