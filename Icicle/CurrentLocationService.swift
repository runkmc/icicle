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
        service.manager.desiredAccuracy = 1000
        service.startGettingLocation()
        return service
    }()
        
    fileprivate let manager = CLLocationManager()
    fileprivate var gotLocation:((Location) -> ())? = nil
    var currentLocation: CLLocation? = nil
    var location: Location? = nil
    let geoCoder = CLGeocoder()
    
    fileprivate override init() { }
    
    fileprivate func startGettingLocation(status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func processLocation(loc:CLLocation) {
        if let alreadyProcessedLocation = self.location {
            self.gotLocation?(alreadyProcessedLocation)
            return
        }
        
        geoCoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            if let mark = placemarks?.first {
                let possibleNames = mark.locality ?? mark.subAdministrativeArea
                let name = possibleNames ?? "Current Location"
                let location = Location(coordinates: loc, name: name)
                print(name)
                self.location = location
                self.gotLocation?(location)
            }
        }
    }
}

extension CurrentLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startGettingLocation(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.currentLocation == nil {
            self.currentLocation = locations.first!
            processLocation(loc: locations.first!)
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}

extension CurrentLocationService: LocationService {
    func getLocation(completion:@escaping (Location) -> ()) {
        self.gotLocation = completion
        if let loc = self.currentLocation {
            processLocation(loc: loc)
        }
    }
}
