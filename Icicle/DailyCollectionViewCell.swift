//
//  DailyCollectionViewCell.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/14/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var precip: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func display(_ day:DayData) {
        self.date.text = day.date
        self.high.text = day.high
        self.low.text = day.low
        self.sunrise.text = day.sunrise
        self.sunset.text = day.sunset
        self.precip.text = day.precipChance
        self.summary.text = day.summary
    }
}
