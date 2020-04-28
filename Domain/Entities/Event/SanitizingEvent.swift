//
//  SanitizingEvent.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-03-12.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct SanitizingEvent: EventProtocol {
  
  public let id = EventId.sanitizing.rawValue
  public let title: String
  public let instruction: String
  
  public init(){
    self.title = NSLocalizedString("Event_Sanitizing_Title", comment: "")
    self.instruction = NSLocalizedString("Event_Sanitizing_Content", comment: "")
  }
  public func asEventType() -> EventType {
    return .sanitizing(self)
  }
  public func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel? {
    
		return nil
    
  }
  public func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask? {
    return LocationAlertTask(condition: { (type) -> Bool in
      if type == .entering {
         return true
      }
     return false
    }) { [instruction, notification] in
      let locTitle = NSLocalizedString("All_Event_Location_Entering_Title", comment: "")
      notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 3, fireDate: Date().addingTimeInterval(300), eventType: .sanitizing(SanitizingEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "SanitizingEvent"
  }
}
