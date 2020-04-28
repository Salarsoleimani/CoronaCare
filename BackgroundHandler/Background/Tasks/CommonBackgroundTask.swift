//
//  CommonBackgroundTask.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/21/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import BackgroundTasks

struct CommonBackgroundTask{
	let scheduleTimeInMinutes: TimeInterval
	let taskId: String
	let expirationHandler: () -> Void
	let taskHandler: () -> Bool
	func register() {
		BGTaskScheduler.shared.register(
			forTaskWithIdentifier: taskId,
			using: nil) { (task) in
				print("Task handler")
				self.execute(task: task as! BGAppRefreshTask)
		}
	}
	
	func execute(task: BGAppRefreshTask) {
		task.expirationHandler = {
			task.setTaskCompleted(success: false)
			self.expirationHandler()
		}
		let completed = self.taskHandler()
		task.setTaskCompleted(success: completed)
		scheduleNext()
	}
	
	func scheduleNext() {
    let nextTask = BGAppRefreshTaskRequest(identifier: taskId)
    nextTask.earliestBeginDate = Date(timeIntervalSinceNow: scheduleTimeInMinutes * 60)
    do {
      try BGTaskScheduler.shared.submit(nextTask)
    } catch {
      print("Unable to submit task: \(error.localizedDescription)")
    }
	}
}
