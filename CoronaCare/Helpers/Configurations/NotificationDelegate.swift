//
//  NotificationDelegate.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-09.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import UserNotifications
import Domain
import NotificationPlatform
import CoreDataPlatform

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
  let notificationCenter = UNUserNotificationCenter.current()

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let content = response.notification.request.content
    let eventIdString = content.categoryIdentifier
    let eventId = EventId(rawValue: Int16(eventIdString) ?? EventId.defaultValue.rawValue) ?? EventId.defaultValue
    let notificationId = response.notification.request.identifier
    var fireDate = Date()
    if let trigger = response.notification.request.trigger as? UNCalendarNotificationTrigger {
      fireDate = trigger.nextTriggerDate() ?? Date()
    }
    switch response.actionIdentifier {
    case "snooze":
      let simpleNotif = SimpleNotificationModel(title: content.title, body: content.body, repeatCount: 1, fireDate: fireDate.addingTimeInterval(TimeInterval(StaticConstants.snoozeMinutes * 60)), eventType: eventId.asEventType())
      NotificationManager.shared.push(notification: simpleNotif, badge: 1)
      setAnswer(answer: .snooze, notificationId: notificationId)
      
    case "done":
      setAnswer(answer: .done, notificationId: notificationId)
      
    case UNNotificationDefaultActionIdentifier:
      goToQuestionPage(notificationId, eventId: eventId)
      
    case UNNotificationDismissActionIdentifier:
      setAnswer(answer: .noAnswer, notificationId: notificationId)
    default:
      print("other action clicked")
    }
  }
  private func setAnswer(answer: AnswerType, notificationId: String) {
    DatabaseManager.shared.set(answer: answer, notificationId: notificationId, completion: nil) { (err) in
      print("error on settig answer in notification delegate: \(err)")
    }

  }
  private func goToQuestionPage(_ notifId: String, eventId: EventId) {
    let question = eventId.asEventType().asEventProtocol().makeQuestion(withNotificationId: notifId) // [TODO] -Force
//    let questionNavigator = QuestionNavigator(navigationController: <#T##UINavigationController#>, dataBase: <#T##DataBaseManagerInterface#>)
  }
  // call whenever user is in app
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let notifContent = notification.request.content
    var fireDate = Date()
    if let trigger = notification.request.trigger as? UNCalendarNotificationTrigger {
      fireDate = trigger.nextTriggerDate() ?? Date()
    }
    let eventId = EventId(rawValue: Int16(notifContent.categoryIdentifier) ?? EventId.defaultValue.rawValue) ?? EventId.defaultValue
    let notifId = notification.request.identifier
    var repeatCount: Int16 = 1
    if let userInfo = notifContent.userInfo as? [String: String] {
      repeatCount = Int16(userInfo["repeatCount"] ?? "1") ?? 1
    }
		(0...10).forEach { (item) in
			Vibrator.vibrate(hardness: 6)
		}
		Application.shared.run()
    print("Notif Umad")
  }
}
