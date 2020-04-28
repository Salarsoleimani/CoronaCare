//
//  GlovesEquipmentEvent.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct GlovesEquipmentEvent: EventProtocol {
  
  public let id = EventId.gloves.rawValue
  public let title: String
  public let instruction: String
  
  public init(){
    self.title = NSLocalizedString("Event_GlovesCare_Title", comment: "")
    self.instruction = NSLocalizedString("Event_GlovesCare_Content", comment: "")
  }
  public func asEventType() -> EventType {
    return .gloves(self)
  }
  
  public func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel? {
    return nil
  }
  
  public func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask? {
    return LocationAlertTask(condition: { (type) -> Bool in
      if type == .exiting {
         return true
      }
     return false
    }) { [instruction, notification] in
      let locTitle = NSLocalizedString("All_Event_Location_Exiting_Title", comment: "")
      notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 3, fireDate: Date().addingTimeInterval(2), eventType: .gloves(GlovesEquipmentEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "GlovesEquipmentEvent"
  }
}
