//
//  WeatherModels.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import Argo

struct WeatherModels {
    let currently:Decoded<Currently>
    let minutes:Decoded<Minutes>
    let hours:Decoded<Hours>
    let days:Decoded<Days>
    let alerts:[Alert]
    let timeZone:TimeZone
}
