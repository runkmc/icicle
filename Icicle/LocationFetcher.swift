//
//  LocationFetcher.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/18/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationFetcher = () -> Result<String, Location>
