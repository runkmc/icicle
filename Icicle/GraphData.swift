//
//  GraphData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/16/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

protocol GraphData {
    
    var title: String { get }
    var currentDataPoint: String { get }
    var color: UIColor { get }
    var high: Int { get }
    var low: Int { get }
    var points: [String] { get }
    var highLabel: String { get }
    var lowLabel: String { get }
    
}
