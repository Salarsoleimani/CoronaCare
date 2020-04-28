//
//  AnswerReminderEvent.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/26/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct AnswerReminderEvent: EventProtocol {
  
  public let id = EventId.answerQuestions.rawValue
  public let title: String
  public let instruction: String
  
  public init(){
    self.title = NSLocalizedString("Event_AnswerReminder_Title", comment: "")
    self.instruction = NSLocalizedString("Event_AnswerReminder_Content", comment: "")
  }
  public func asEventType() -> EventType {
		return .answerReminder(self)
  }
  public func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel? {
		return nil
    
  }
  public func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask? {
    return LocationAlertTask(condition: { (type) -> Bool in
     return true
    }) { [instruction, notification] in
      let locTitle = NSLocalizedString("All_Event_Location_Entering_Title", comment: "")
      notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 3, fireDate: Date().addingTimeInterval(300), eventType: .sanitizing(SanitizingEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "AnswerReminderEvent"
  }
}
