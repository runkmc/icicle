//
//  Hour.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/30/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Hour {	

	let apparentTemperature:Float
	let humidity:Float
	let precipIntensity:Float
	let precipProbability:Float
	let summary:String
	let temperature:Float
	let time:Int
	let icon:String

	init?(data:JSON) {
		if let apparentTemperature = data["apparentTemperature"] as? Float,
		let humidity = data["humidity"] as? Float,
		let precipIntensity = data["precipIntensity"] as? Float,
		let precipProbability = data["precipProbability"] as? Float,
		let summary = data["summary"] as? String,
		let temperature = data["temperature"] as? Float,
		let time = data["time"] as? Int,
		let icon = data["icon"] as? String {
			self.apparentTemperature = apparentTemperature 
			self.humidity = humidity
			self.precipIntensity = precipIntensity
			self.precipProbability = precipProbability
			self.summary = summary
			self.temperature = temperature
			self.time = time
			self.icon = icon
		} else {
			return nil
		}
	}
}
