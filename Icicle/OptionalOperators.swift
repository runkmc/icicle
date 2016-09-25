//
//  OptionalOperators.swift
//  Icicle
//
//  Created by Kevin McGladdery on 9/24/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func >>-<T, U>(opt:T?, f:(T) -> U) -> U? {
    return opt.map(f)
}

func <^><T, U>(opt:T?, f:(T) -> U?) -> U? {
    return opt.flatMap(f)
}
