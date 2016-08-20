//
//  WeatherDataGetter.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/16/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//  The Author suggests saying WeatherDataGetter five times fast.

import Foundation
import CoreLocation

typealias WeatherDataGetter = (location:CLLocation) -> WeatherData
