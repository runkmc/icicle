//
//  LocationServiceTest.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/23/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation
@testable import Icicle

class SavedLocationServiceTest: XCTestCase {
    func testGettingCoordinates() {
        let location = Location(coordinates: CLLocation(latitude: 1337, longitude: 1701), name: "Default City")
        let service = SavedLocationService(location:location)
        service.getLocation() { location in
            XCTAssertEqual(location.coordinate.latitude, 1337)
        }
    }
}
