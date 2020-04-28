//
//  BackgroundTaskProvider.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/21/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import LocationManager
import AppEngine
import GoogleMobileAds
struct BackgroundTaskProvider {
	func makeLocationTask() -> CommonBackgroundTask {
		return CommonBackgroundTask(scheduleTimeInMinutes: 5, taskId: "com.BEKSAS.RefreshLocation", expirationHandler: {
			print("Location CBackground task expired")
		}) { [manager = LocationManager.shared]() -> Bool in
			manager.refresh()
			return true
		}
	}
	
	func makeNotificationTask() -> CommonBackgroundTask {
		return CommonBackgroundTask(scheduleTimeInMinutes: 15, taskId: "com.BEKSAS.RefreshNotifications", expirationHandler: {
			print("Notificaiton CBackground task expired")
		}) { [manager = AppEngine.shared]() -> Bool in
			manager.refreshNotification()
			return true
		}
	}
	
	func makeAnswerReminderTask() -> CommonBackgroundTask {
		return CommonBackgroundTask(scheduleTimeInMinutes: 60, taskId: "com.BEKSAS.CustomReminder", expirationHandler: {
			print("Notificaiton CBackground task expired")
		}) { [manager = AppEngine.shared]() -> Bool in
//			manager.refreshNotification() [TODO]
			return true
		}
	}

}
