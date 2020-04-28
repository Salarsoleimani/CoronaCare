//
//  AppEngine.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation
import NotificationPlatform
import LocationManager
import CoreDataPlatform
import Domain

public final class AppEngine {
	public static let shared = { () -> AppEngine in
		let result = AppEngine()
		LocationManager.shared.setDelegate(dataBaseDelegate: DatabaseManager.shared, appEngineDelegate: result)
		return result
	}()
	
	var isRunning = false
	var safetyLevel: SafetyLevel = SafetyLevel.defaultLevel
	
	private(set) var events = SafetyLevel.defaultLevel.makeEvents()
	
	public func run(id: String) {
		isRunning = true
		logger(meesage:"Running AppEngine withID \(id)")
		setup()
	}
	
	public func runIfNeeded(id: String) {
		
		if !isRunning {
			run(id: id)
		}
	}
	
	public func refresh() {
		LocationManager.shared.refresh()
	}
}

extension AppEngine {
	func setup() {
		logger(meesage:"Setting up AppEngine")
		LocationManager.shared.setDelegate(dataBaseDelegate: DatabaseManager.shared, appEngineDelegate: AppEngine.shared)
		setupLocationAlerts()
		setupScheduledEvents()
		
	}
	public func refreshLocation() {
		LocationManager.shared.resetFactory()
		LocationManager.shared.refresh()
		setupLocationAlerts()
		
	}
	
	func setupLocationAlerts(){
		logger(meesage:"Setting up AppEngine LocationLerts")
		//Finding Regions with the configurations
		DatabaseManager.shared.getRegionConfigurations(response: { [logger](regions) in
			
			//making LocationAlert for each config
			regions.forEach { [locationServices = LocationManager.shared, notificationServices = NotificationManager.shared, dataBaseServices = DatabaseManager.shared, logger] (config) in
				
				let region = RegionModel(withCenter: CLLocationCoordinate2D(latitude: config.latitude, longitude: config.longitude), radiusInMeter: config.radius)
				let tasks = config.events.compactMap { (item) -> LocationAlertTask? in
					return item.makeLocationTask(notification: notificationServices)
				}
				let locationAlert = LocationAlert(tasks: tasks, region: region)
				
					dataBaseServices.getLocationLogs(withPrediction: nil, response: { [locationServices = LocationManager.shared, logger, locationAlert](logs) in
						if let safeLocation = logs.first {
							_ = locationAlert.region.updateState(forCoordinate: CLLocationCoordinate2D(latitude: safeLocation.latitude, longitude: safeLocation.longitude))
						}
						do {
							try locationServices.set(alert: locationAlert)
						} catch let error {
							logger(error, "error while setupLocationAlerts() in AppEngine received error locationService to set new Alert: \(error)")
						}
					}) { [locationServices, logger, locationAlert](error) in
						do {
							try locationServices.set(alert: locationAlert)
						} catch let error {
							logger(error, "error while setupLocationAlerts() in AppEngine received error locationService to set new Alert: \(error)")
						}
					}
			}
		}) { [logger, locationServices = LocationManager.shared, dataBaseServices = DatabaseManager.shared](error) in
			
			if error.asCoreDataError() == .isEmpty {
				do {
					
					let region = try locationServices.getCurrentRegion(withRadiusInMeter: RegionModel.defaultRegionRadius)
					
					dataBaseServices.add(regionConfig: RegionConfigurationModel(id: UUID().uuidString, latitude: region.region.center.latitude, longitude: region.region.center.longitude, radius: region.region.radius, title: "Safe 1", events: events.compactMap{$0.asEventProtocol()})) { [logger, manager = AppEngine.shared] (updated) in
						if updated {
							manager.setupLocationAlerts()
						} else {
							
							let error = NSError(domain: "DataBase", code: 503, userInfo: ["message" : "Failed to insert new regionConfiguration to the dataBase"])
							logger(error, "error while adding a new region to dataBase \(error)")
						}
					}
				} catch let error {
					logger(error, "error while setup() in AppEngine received empty location: \(error)")
				}
				
			} else {
				logger(error, "error while setup() in AppEngine received error from dataBase: \(error)")
			}
		}
	}
	
	func setupScheduledEvents() {
		logger(meesage:"Setting up AppEngine Scheduled events")
		events.forEach { [notificationServices = NotificationManager.shared, safetyLevel, logger] (type) in
			if let config = type.asEventProtocol().makeConfig(forSafetyLevel: safetyLevel) {
				logger(nil, "eventID: -> \(type.asEventProtocol().getName())")
				notificationServices.set(event: type.asEventProtocol(), configuration: config)
			}
		}
	}
	
	public func changeConfig(toSafetyLevel level: SafetyLevel) {
		logger(meesage:"Setting up AppEngine SafetyLevel \(level)")
		
		//Change the app engine safty level
		safetyLevel = level
		//Make new events for the selected safetyLevel
		events = level.makeEvents()
		
		//reset everything to start with new events
		resetFactory()
		
		//setup for new events
		setup()
		
	}
	public func refreshNotification() {
		NotificationManager.shared.resetFactory()
		setupScheduledEvents()
	}
	
	public func notificationConfigChanged(config: UserInfoModel) {
		changeConfig(toSafetyLevel: config.saftyLevel)
	}
	
	func logger(error: Error? = nil, meesage: String) {
		if error != nil {
			print("\n\n$> logged: Error \(meesage)\n\n")
		}else {
			print("\n\n$> logged: \(meesage)\n\n")
		}
	}
	
}

extension AppEngine: ResetableFrameworkProtocol{
	public func resetFactory() {
		logger(meesage:"Reseting AppEngine")
		LocationManager.shared.resetFactory()
		NotificationManager.shared.resetFactory()
	}
}

extension AppEngine: AppEngineDelegate{
	public func locationUpdates() {
		runIfNeeded(id: "Location Delegate")
	}
}
