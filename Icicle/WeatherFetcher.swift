//
//  WeatherFetcher.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

typealias WeatherFetcher = (_ location:LocationFetcher) -> Result<[String], WeatherData>
