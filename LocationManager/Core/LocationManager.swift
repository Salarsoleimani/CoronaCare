//
//  LocationManager.swift
//  LocationManager
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation
import Domain
import UserNotifications

public final class LocationManager: NSObject, LocationManagerInterface {
	
	public static let shared: LocationManager =  {
		let result = LocationManager()
		result.system.delegate = result
		result.system.allowsBackgroundLocationUpdates = true
		result.system.pausesLocationUpdatesAutomatically = false
		result.system.desiredAccuracy = kCLLocationAccuracyBest
		result.system.activityType = .fitness
		result.system.distanceFilter = 0
		result.startSignificantLocationChanges()
		return result
		
	}()
	var isRunningTests: Bool {
			return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
	var latestLocationLog: CLLocation?
  let notificationCenter = UNUserNotificationCenter.current()
  func scheduleNotification(title: String, body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    let date = Date(timeIntervalSinceNow: 15)
    let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    let identifier = "Local Notification"
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
      if let error = error {
        print("Error \(error.localizedDescription)")
      }
    }
  }
	private let system = CLLocationManager()
	public var dataBaseDelegate: DataBaseManagerInterface?
	public var appEngineDelegate: AppEngineLocationDelegate?
	public private(set) var alerts = [LocationAlert]()
	
	public func setDelegate(dataBaseDelegate: DataBaseManagerInterface?, appEngineDelegate: AppEngineLocationDelegate?){
		
		self.dataBaseDelegate = dataBaseDelegate
		self.appEngineDelegate = appEngineDelegate
	}
	private func update(location : CLLocation) {
		print("\(Constants.Printable.lineSeparator)New location update received!\nUPDATING...")
		alerts.forEach { item in
			if item.region.updateState(forCoordinate: location.coordinate) {
				let state = item.region.currentState!
				
				item.fire(eventType: state.asAlertType())
			}
			print("item with id '\(item.id)' and region (\(item.region.region.center)) updated!")
		}
		print("\(Constants.Printable.lineSeparator)")
	}
	
	private func update(region: CLRegion, state: RegionStateType){
		alerts.forEach { [region] (alert) in
			if alert.region.region.identifier == region.identifier {
				alert.region.update(state: state)
				alert.fire(eventType: state.asAlertType())
			}
		}
	}
	
	private func startSignificantLocationChanges() {
		if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
			return
		}
		system.startMonitoringSignificantLocationChanges()
	}
	public func getCurrentRegion(withRadiusInMeter radius: Double) throws -> RegionModel{
		guard let center = getCurrentLocation() else {
			throw NSError(domain: "Location not found", code: 404, userInfo: ["message" : "Current location is null."])
		}
		return RegionModel(withCenter: center.coordinate, radiusInMeter: radius)
	}
	public func getCurrentLocation() -> CLLocation? {
		if isRunningTests {
			let testableCoordinate = CLLocationCoordinate2D(latitude: 35.73698318, longitude: 50.97934673)
			return CLLocation(coordinate: testableCoordinate, altitude: 0.0, horizontalAccuracy: CLLocationAccuracy(exactly: 65.0)!, verticalAccuracy: CLLocationAccuracy(exactly: 65.0)!, course: CLLocationDirection(exactly: 0.0)!, speed: CLLocationSpeed(exactly: 1.0)!, timestamp: Date())
		}
		return system.location ?? latestLocationLog
	}
	public func set(alert: LocationAlert) throws {
		if alerts.filter({ $0 == alert }).isEmpty {
			alerts.append(alert)
			system.requestLocation()
			system.startMonitoring(for: alert.region.region)
			return
		}
		throw NSError(domain: "Bad request", code: 400, userInfo: ["message" : "This alert you trying to add is set before!"])
	}
	
	public func refresh(){
		system.startMonitoringSignificantLocationChanges()
		system.requestLocation()
		if let safeLocation = getCurrentLocation() {
			update(location: safeLocation)
		}
	}
}

extension RegionStateType {
	func asAlertType() -> LocationAlertType {
		return self == .inside ? LocationAlertType.entering : .exiting
	}
	func revert() -> RegionStateType {
		
		return self == .inside ? .outside : .inside
	}
}

extension LocationManager: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		latestLocationLog = locations.first
		appEngineDelegate?.locationUpdates()
		print("A\(appEngineDelegate != nil) D\(dataBaseDelegate != nil)")
		scheduleNotification(title: "locationManager A\(appEngineDelegate != nil) D\(dataBaseDelegate != nil)", body: "didUpdateLocations: \(locations)")
		print("\(Constants.Printable.lineSeparator) LocationUpdate Recieved: -> \n \(locations) \(Constants.Printable.lineSeparator)")
		
		if let safeLocation = locations.last,
			safeLocation.verticalAccuracy <= RegionModel.defaultRegionRadius &&
			safeLocation.horizontalAccuracy <= RegionModel.defaultRegionRadius {
			
			dataBaseDelegate?.log(Location: LocationLogModel(id: UUID().uuidString , latitude: safeLocation.coordinate.latitude, longitude:  safeLocation.coordinate.longitude, date: Date()), completion: { (updated) in
				if updated {
					print(" Location logged successfully \n")
				}
			})
			
			update(location: safeLocation)
			return
		}
		
		system.requestLocation()
	}
  public func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
    scheduleNotification(title: "locationManager", body: "locationManagerDidResumeLocationUpdates")

  }
  public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
    scheduleNotification(title: "locationManager", body: "didStartMonitoringFor: \(region.identifier)")

  }
	public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    scheduleNotification(title: "locationManager", body: "didEnterRegion: \(region.identifier)")

		refresh()
		update(region: region, state: .inside)
	}
	
	public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    scheduleNotification(title: "locationManager", body: "didExitRegion: \(region.identifier)")

		refresh()
		update(region: region, state: .outside)
	}
	
	public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
    scheduleNotification(title: "locationManager", body: "monitoringDidFailFor: \(region?.identifier ?? "nil region")")

		refresh()
		print("\(Constants.Printable.lineSeparator) monitoringDidFailFor: -> \(region?.identifier ?? "Empty") \n error: \(error) \(Constants.Printable.lineSeparator)")
	}
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    scheduleNotification(title: "locationManager", body: "didFailWithError: \(error)")

//		if let error = error as? CLError, error.code == .denied {
//			system.stopMonitoringSignificantLocationChanges()
//			return
//		}
	}
}

extension LocationManager: ResetableFrameworkProtocol{
	public func resetFactory() {
		alerts.forEach { [system](alert) in
			system.stopMonitoring(for: alert.region.region)
		}
		alerts = [LocationAlert]()
	}
}

extension LocationManager {
	public func _testableSystemManager() -> CLLocationManager {
		return system
	}
}
