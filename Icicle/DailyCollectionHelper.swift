//
//  DailyCollectionHelper.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/14/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

class DailyCollectionHelper: NSObject {
    var weather: WeatherData? = nil
    
    init(weather:WeatherData?) {
        self.weather = weather
    }
}

extension DailyCollectionHelper: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weather?.days.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! DailyCollectionViewCell
        cell.display(self.weather!.days[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "dayheader", for: indexPath)
        return header
    }
}

extension DailyCollectionHelper: UICollectionViewDelegate { }
