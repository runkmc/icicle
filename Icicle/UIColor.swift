//
//  UIColor.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/19/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex:UInt32) {
        let red = (hex & 0xFF000000) >> 24
        let green = (hex & 0x00FF0000) >> 16
        let blue = (hex & 0x0000FF00) >> 8
        let alpha = hex & 0x000000FF
        
        self.init(red: CGFloat(Float(red)/255), green: CGFloat(Float(green)/255), blue: CGFloat(Float(blue)/255), alpha: CGFloat(Float(alpha)/255))
    }
}
