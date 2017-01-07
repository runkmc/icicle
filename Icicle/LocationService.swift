//
//  LocationService.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/6/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationService {
    var gotLocation:((CLLocation) -> ())? { get set }
    func getLocation()
}
