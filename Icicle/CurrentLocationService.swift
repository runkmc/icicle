//
//  LocationService.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/23/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationService: NSObject {
    static let instance = CurrentLocationService()
    fileprivate let manager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    fileprivate override init() { }
    
    fileprivate func startGettingLocation(status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension CurrentLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.startGettingLocation(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
