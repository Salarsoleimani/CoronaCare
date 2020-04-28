//
//  LocationTestUtils.swift
//  LocationManagerTests
//
//  Created by Behrad Kazemi on 3/30/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation
import Domain
struct LocationTestUtils {
	static func makeTestableLogs() -> [CLLocationCoordinate2D]{
		return [CLLocationCoordinate2D(latitude: 35.73798619, longitude: 50.97997550),
						CLLocationCoordinate2D(latitude: 35.73907860, longitude: 50.98089771),
						CLLocationCoordinate2D(latitude: 35.73780972, longitude: 50.99799961),
						CLLocationCoordinate2D(latitude: 35.73698318, longitude: 50.97934673),
						CLLocationCoordinate2D(latitude: 35.73698319, longitude: 50.97934674),//Stable - No big changes
						CLLocationCoordinate2D(latitude: 35.73698318, longitude: 50.97934675),//Stable - No big changes
						CLLocationCoordinate2D(latitude: 35.73798619, longitude: 50.97997550),
						CLLocationCoordinate2D(latitude: 35.73798619, longitude: 50.97997552),//Stable - No big changes
						CLLocationCoordinate2D(latitude: 35.73907860, longitude: 50.98089771),
						CLLocationCoordinate2D(latitude: 35.73780972, longitude: 50.99799961),
						CLLocationCoordinate2D(latitude: 35.73698318, longitude: 50.97934673)
		]
	}
	
	static func makeTestableRegion() -> RegionModel{
		let safePlaceCenter = CLLocationCoordinate2D(latitude: 35.73698318, longitude: 50.97934673)
		let region = RegionModel(withCenter: CLLocationCoordinate2D(latitude: safePlaceCenter.latitude, longitude: safePlaceCenter.longitude), radiusInMeter: 70)
		return region
	}
}
