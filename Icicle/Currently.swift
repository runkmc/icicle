//
//  Currently.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/11/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct Currently {
	let apparentTemperature:Float?
	let icon:String?
	let temperature:Float?
    let time: Double?

    init(data:JSON) {
		self.apparentTemperature = data["apparentTemperature"] as? Float
		self.icon = data["icon"] as? String
		self.temperature = data["temperature"] as? Float
        self.time = data["time"] as? Double 
	}
}
