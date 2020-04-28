//
//  MaskEquipmentEvent.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct MaskEquipmentEvent: EventProtocol {

  public let id = EventId.mask.rawValue
  public let title: String
  public let instruction: String
  
  public init(){
    self.title = NSLocalizedString("Event_MaskCare_Title", comment: "")
    self.instruction = NSLocalizedString("Event_MaskCare_Content", comment: "")
  }
  public func asEventType() -> EventType {
    return .mask(self)
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
			notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 8, fireDate: Date().addingTimeInterval(2), eventType: .mask(MaskEquipmentEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "MaskEquipmentEvent"
  }
  
}
