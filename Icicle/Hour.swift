//
//  Hour.swift
//  Icicle
//
//  Created by Kevin McGladdery on 7/30/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Hour {	

	let apparentTemperature:Float?
	let humidity:Float?
	let precipIntensity:Float?
	let precipProbability:Float?
	let summary:String?
	let temperature:Float?
	let time:Int?
	let icon:String?

	init(data:JSON) {
		self.apparentTemperature = data["apparentTemperature"] as? Float
		self.humidity = data["humidity"] as? Float
		self.precipIntensity = data["precipIntensity"] as? Float
		self.precipProbability = data["precipProbability"] as? Float
		self.summary = data["summary"] as? String
		self.temperature = data["temperature"] as? Float
		self.time = data["time"] as? Int
		self.icon = data["icon"] as? String
	}
}
