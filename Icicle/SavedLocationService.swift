//
//  SavedLocationService.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/6/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation
import CoreLocation

class SavedLocationService {
    let location:Location
    
    init(location:Location) {
        self.location = location
    }
}

extension SavedLocationService {
    func getLocation(completion:@escaping (CLLocation) -> ()) {
        completion(self.location.coordinates)
    }
}
