//
//  HourlyCollection.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/14/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

class HourlyCollectionHelper: NSObject {
    var weather: WeatherData? = nil
    
    init(weather:WeatherData?) {
        self.weather = weather
    }
}

extension HourlyCollectionHelper: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weather?.hours.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hour", for: indexPath) as! HourlyCollectionViewCell
        cell.display(self.weather!.hours[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        return header
    }
}

extension HourlyCollectionHelper: UICollectionViewDelegate { }
