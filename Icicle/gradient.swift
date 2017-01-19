//
//  gradient.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/19/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

func gradientFor(weather: WeatherIcon, view: UIView) -> CAGradientLayer {
    var color1: UIColor
    var color2: UIColor
    switch weather {
    case .clearNight:
        color1 = UIColor(hex: 0x2980B9FF)
        color2 = UIColor(hex: 0x2C3E50FF)
    case .rain:
        color1 = UIColor(hex: 0xF1F2B5FF)
        color2 = UIColor(hex: 0x135058FF)
    case .snow, .sleet, .fog, .cloudy, .wind:
        color1 = UIColor(hex: 0xEEF2F3FF)
        color2 = UIColor(hex: 0x8E8EABFF)
    case .partlyCloudyDay:
        color1 = UIColor(hex: 0x928DABFF)
        color2 = UIColor(hex: 0x00D2FFFF)
    case .partlyCloudyNight:
        color1 = UIColor(hex: 0xF0F2F0FF)
        color2 = UIColor(hex: 0x000C40FF)
    case .unknown, .clearDay:
        color1 = UIColor(hex: 0xFF6A00FF)
        color2 = UIColor(hex: 0xEE0979FF)
    }
    
    let gradient = CAGradientLayer()
    gradient.colors = [color1.cgColor, color2.cgColor]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = view.bounds
    return gradient
}
