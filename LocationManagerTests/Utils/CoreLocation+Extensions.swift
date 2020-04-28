//
//  CoreLocation+Extensions.swift
//  LocationManagerTests
//
//  Created by Behrad Kazemi on 3/30/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
	func asLocation() -> CLLocation {
		return CLLocation(coordinate: self, altitude: 0.0, horizontalAccuracy: CLLocationAccuracy(exactly: 65.0)!, verticalAccuracy: CLLocationAccuracy(exactly: 65.0)!, course: CLLocationDirection(exactly: 0.0)!, speed: CLLocationSpeed(exactly: 1.0)!, timestamp: Date())
		
	}
}
