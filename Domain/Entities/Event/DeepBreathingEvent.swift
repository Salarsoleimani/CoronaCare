//
//  DeepBreathingEvent.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-03-31.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct DeepBreathingEvent: EventProtocol {
  
  public let id = EventId.deepBreath.rawValue
  public let title: String
  public let instruction: String
  
  public init() {
    self.title = NSLocalizedString("Event_HandsCare_Title", comment: "")
    self.instruction = NSLocalizedString("Event_HandsCare_Content", comment: "")
  }
  public func asEventType() -> EventType {
    return .deepBreath(self)
  }
  public func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel? {
    
    switch level {
    case .low:
      return ScheduledNotificationConfigModel(eventId: self.id, scheduledCycleTime: 360, repeatCount: 1)
    case .basic:
      return ScheduledNotificationConfigModel(eventId: self.id, scheduledCycleTime: 160, repeatCount: 2)
    case .medium:
      return ScheduledNotificationConfigModel(eventId: self.id, scheduledCycleTime: 90, repeatCount: 3)
    case .high:
      return ScheduledNotificationConfigModel(eventId: self.id, scheduledCycleTime: 60, repeatCount: 4)
    case .veryHigh:
      return ScheduledNotificationConfigModel(eventId: self.id, scheduledCycleTime: 40, repeatCount: 4)
    }
    
  }
  public func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask? {
    return LocationAlertTask(condition: { (type) -> Bool in
      if type == .entering {
        return true
      }
      return false
    }) { [instruction, notification] in
      let locTitle = NSLocalizedString("All_Event_Location_Entering_Title", comment: "")
      notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 3, fireDate: Date().addingTimeInterval(15), eventType: .hands(HandsCareEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "DeepBreathingEvent"
  }
}
