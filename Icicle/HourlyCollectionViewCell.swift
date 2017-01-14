//
//  HourlyCollectionViewCell.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/13/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    @IBOutlet weak var precipChance: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func display(_ hour:HourData) {
        self.time.text = hour.time
        self.summary.text = hour.summary
        self.temperature.text = hour.temperature
        self.apparentTemperature.text = hour.apparentTemperature
        self.precipChance.text = hour.precipChance
        self.humidity.text = hour.humidity
    }
}
