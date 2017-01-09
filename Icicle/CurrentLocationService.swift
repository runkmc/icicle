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
    static let instance: CurrentLocationService = {
        let service = CurrentLocationService()
        service.manager.delegate = service
        service.startGettingLocation()
        return service
    }()
        
    fileprivate let manager = CLLocationManager()
    fileprivate var gotLocation:((CLLocation) -> ())? = nil
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
        startGettingLocation(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            self.currentLocation = loc
            self.gotLocation?(loc)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

extension CurrentLocationService: LocationService {
    func getLocation(completion:@escaping (CLLocation) -> ()) {
            self.gotLocation = completion
            if let loc = self.currentLocation {
                completion(loc)
            }
    }
}
