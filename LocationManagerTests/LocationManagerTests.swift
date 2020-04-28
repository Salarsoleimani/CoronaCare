//
//  LocationManagerTests.swift
//  LocationManagerTests
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Domain
@testable import CoreDataPlatform
@testable import LocationManager
@testable import AppEngine


class LocationManagerTests: XCTestCase {
	
	var manager: LocationManager?
	var dataBase: DataBaseManagerInterface?
	override func setUp() {
		manager = LocationManager.shared
		dataBase = DatabaseManager.shared
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		manager = nil
		dataBase = nil
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testAlertFiring(){
		print("\(Constants.Printable.lineSeparator) TESTING AlertFiring")
		manager?.resetFactory()
		manager?.setDelegate(dataBaseDelegate: DatabaseManager.shared, appEngineDelegate: nil)
		let locationLogs = LocationTestUtils.makeTestableLogs()
		let region = LocationTestUtils.makeTestableRegion()
		
		let firstDistance = region.region.center.asLocation().distance(from: locationLogs.first!.asLocation())
		print("Test: ->  First distance: \(firstDistance)")
		
		var eventStatusIndex = 0
		let expectedStatus: [LocationAlertType] = [.entering, .exiting, .entering]
		
		let task = LocationAlertTask(condition: { (status) -> Bool in
			print("Test -> status: \(status) -> Expected: \(expectedStatus[eventStatusIndex])")
			XCTAssertTrue(expectedStatus[eventStatusIndex] == status)
			eventStatusIndex += 1
			return true
		}) {
			print("Test -> action!")
		}
		let locationAlert = LocationAlert(tasks: [task], region: region)
		do {
			
			try manager?.set(alert: locationAlert)
			print("Test -> Start Testing With Logs")
			locationLogs.forEach { (coordinate) in
				print("Test -> Logs")
				manager?.locationManager(manager?._testableSystemManager() ?? CLLocationManager(), didUpdateLocations: [coordinate.asLocation()])
			}
			
		} catch let error {
			print(error)
		}
		print("\(Constants.Printable.lineSeparator)")
	}
	
	func testSettingUpEventWithNewLocationUpdate(){
		print("\(Constants.Printable.lineSeparator) TESTING Engine Running with new location Update")
		
		manager?.resetFactory()
		let coordination = LocationTestUtils.makeTestableLogs().randomElement()!
			
		manager?.locationManager(manager?._testableSystemManager() ?? CLLocationManager(), didUpdateLocations: [coordination.asLocation()])
		
		
		let exp = expectation(description: "Test after 15 seconds")
		let result = XCTWaiter.wait(for: [exp], timeout: 15.0)
		if result == XCTWaiter.Result.timedOut {
			print("Test -> Events count: \(manager?.alerts.count) -> Expected: >= 1")
			XCTAssertTrue((manager?.alerts.count ?? 0) > 0)
		} else {
			XCTFail("Delay interrupted")
		}
		
	}
	
	
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
	
}
