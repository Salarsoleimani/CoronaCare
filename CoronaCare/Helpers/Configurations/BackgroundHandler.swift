//
//  BackgroundHandler.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/21/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation


struct BackgroundHandler {
	static let shared = BackgroundHandler()
	let provider = BackgroundTaskProvider()
	let tasks: [CommonBackgroundTask]
	var isRunningTests: Bool {
			return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
	private init(){

		self.tasks = [provider.makeLocationTask(),
									provider.makeNotificationTask()]
	}
	
	func registerTasks() {
		if isRunningTests {
			return
		}
		
		print("Registering backgroundTasks")
		tasks.forEach { (item) in
			item.register()
		}
	}
	
	func scheduleTasks() {
		tasks.forEach { (item) in
			item.scheduleNext()
		}
	}
	
}
