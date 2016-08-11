//
//  Currently.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/11/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Currently {
	let apparentTemperature:Float
	let icon:String
	let temperature:Float

	init?(data:JSON) {
		if let apparentTemperature = data["apparentTemperature"] as? Float,
		let icon = data["icon"] as? String,
		let temperature = data["temperature"] as? Float {
			self.apparentTemperature = apparentTemperature
			self.icon = icon
			self.temperature = temperature
        } else {
            return nil
        }
	}
}
