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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func display(_ hour:HourData) {
        self.time.text = hour.time
    }

}
