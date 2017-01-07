//
//  WeatherError.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/7/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case urlError(String)
    case httpError(String)
    case missingData
    case decodingError(String)
    case formattingError(String)
}
