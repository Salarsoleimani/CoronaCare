//
//  NotificationManager.swift
//  NotificationPlatform
//
//  Created by Salar Soleimani on 2020-03-04.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Domain
import SwiftLocalNotification
import CoreDataPlatform
import UIKit

public class NotificationManager: NSObject, NotificationManagerInterface {
  public static let shared = NotificationManager()
  private let scheduler = SwiftLocalNotification()
  var notificationCountPerEvent = 15
  
  public func set(event: EventProtocol, configuration: ScheduledNotificationConfigModel) {
    print("Notification Manager: Setting \(event.getName())")
    //[TODO] use the configuration for schedualing
    let repeatedSeconds = TimeInterval(configuration.scheduledCycleTime * 60)
    switch event.asEventType() {
    case let .hands(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .vitaminC(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .mask(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .gloves(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .sanitizing(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .answerReminder(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      break
      
    case let .custom(extractedModel):
      add(notificationSetting: extractedModel, repeatedSeconds: repeatedSeconds)
      
    case .drinkingWater(_):
      print("[TODO] -meduim")
      
    case .deepBreath(_):
      print("[TODO] -meduim")
      
    case .meditation(_):
      print("[TODO] -meduim")
      
    }
  }
  
  public func remove(event: EventProtocol) {
    print("Notification Manager: Remove \(event.getName())")
    let scheduledNotifications = scheduler.getAllScheduledNotifications()
    let filteredNotif = scheduledNotifications.filter{ $0.category == String(event.id) }.map{$0.asSimpleNotificationModel()}
    scheduler.cancel(notificationIds: filteredNotif.map{$0.id})

    DatabaseManager.shared.delete(NotificationIds: filteredNotif.map{$0.id}) { (updated) in
      print("all further scheduled notificaiton deleted with error: \(updated)")
    }
  }
  
  public func upNextNotifications(forEvent event: EventProtocol, response: @escaping ([SimpleNotificationModel]) -> Void) {
    response(scheduler.getAllScheduledNotifications().map{ $0.asSimpleNotificationModel()})
  }
  
  fileprivate func setNotificationActions(_ categoryName: String) {
    let snoozeMinutes: Int = UserDefaults.standard.integer(forKey: "com.storageKey.snoozeMinutes") > 0 ? UserDefaults.standard.integer(forKey: "com.storageKey.snoozeMinutes") : 2
    
    let snoozeAction = UNNotificationAction(identifier: "snooze", title: String(format: NSLocalizedString( "Notification_Button_Action_Title_Snooze", comment: ""), snoozeMinutes), options: [])
    let doneAction = UNNotificationAction(identifier: "done", title: NSLocalizedString("Notification_Button_Action_Title_Done", comment: ""), options: [])
    
    let category = SwiftLocalNotificationCategory(categoryIdentifier: categoryName, actions: [snoozeAction, doneAction])
    category.set()
  }
  
  private func add(notificationSetting: EventProtocol, repeatedSeconds: TimeInterval) {
    print("Notification Manager: Adding \(notificationSetting.getName())")
    //let soundName = category + ".wav"
    let repeatCount = notificationSetting.makeConfig(forSafetyLevel: .defaultLevel)?.repeatCount ?? 1
    
    DatabaseManager.shared.getUserInfo(response: { [repeatedSeconds, notificationSetting] (userInfo) in
      let sleepTime = userInfo.sleepTime ?? "24:00"
      let wakeupTime = userInfo.wakeupTime ?? "08:00"
      let sleepTimeDate = Date().getTodaysDateFor(timeString: sleepTime)
      let wakeupTimeDate = Date().getTodaysDateFor(timeString: wakeupTime)

      let notification = SwiftLocalNotificationModel(title: notificationSetting.title, body: notificationSetting.instruction, date: sleepTimeDate, repeating: .daily)
      
      notification.category = notificationSetting.getName()
      setNotificationActions(notificationSetting.getName())

      _ = scheduler.schedule(notification: notification, fromDate: sleepTimeDate, toDate: wakeupTimeDate, interval: repeatedSeconds)

    }) { [repeatedSeconds, notificationSetting] (err) in
      let defaultSleepTime = "23:59"
      let defaultWakeTime = "08:00"
      let sleepTimeDate = Date().getTodaysDateFor(timeString: defaultSleepTime)
      let wakeupTimeDate = Date().getTodaysDateFor(timeString: defaultWakeTime)
      
      let notification = SwiftLocalNotificationModel(title: notificationSetting.title, body: notificationSetting.instruction, date: sleepTimeDate, repeating: .daily)
      
      notification.category = notificationSetting.getName()
      setNotificationActions(notificationSetting.getName())

      _ = scheduler.schedule(notification: notification, fromDate: sleepTimeDate, toDate: wakeupTimeDate, interval: repeatedSeconds)

    }
  }
  
  public func push(notification: SimpleNotificationModel, badge: Int?) {
    let eventName = String(notification.eventType.asEventProtocol().id)
    let swiftNotification = SwiftLocalNotificationModel(title: notification.title, body: notification.body, date: notification.fireDate, repeating: .none, identifier: notification.id, subtitle: nil, soundName: eventName + ".wav", badge: badge)
    do {
      guard let imageUrl = Bundle.main.url(forResource: eventName, withExtension: "png") else { return }
      let attachement = try UNNotificationAttachment(identifier: "image", url: imageUrl, options: nil)
      swiftNotification.attachments = [attachement]
    } catch let err {
      print("Error on adding image attachment to notification: \(err)")
    }
    swiftNotification.category = eventName
    setNotificationActions(eventName)

    _ = scheduler.schedule(notification: swiftNotification)
    let answer = notification.fireDate.timeIntervalSinceNow < 10 ? AnswerType.noAnswer : AnswerType.unknown
    DatabaseManager.shared.log(Notification: notification.asNotificationLog(answerStatus: answer)) { (updated) in
      //      print(updated)
    }
    
  }
}

extension NotificationManager: ResetableFrameworkProtocol{
  public func resetFactory() {
    print("Notification Manager: ResetFactory")
    let scheduler = DLNotificationScheduler()
    scheduler.getScheduledNotifications { (notifs) in
      if let notifs = notifs {
        let notifIds = notifs.map{$0.identifier}
        DatabaseManager.shared.delete(NotificationIds: notifIds) { [scheduler] (updated) in
          print("all further scheduled notificaiton deleted with error: \(updated)")
          scheduler.cancelAlllNotifications()
        }
      }
    }
  }
}
