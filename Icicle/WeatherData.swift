//
//  WeatherData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit
import CoreLocation

struct WeatherData {
    
    let icon: UIImage
    
    init(minutes:Minutes, hours:Hours, days:Days, currently:Currently) {
        let iconName = currently.icon ?? "blank"
        self.icon = UIImage(named:iconName)!
    }
    
}
