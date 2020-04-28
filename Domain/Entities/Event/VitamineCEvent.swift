//
//  VitaminCEvent.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//
import Foundation

public struct VitaminCEvent: EventProtocol {
  public let id = EventId.vitaminC.rawValue
  public let title: String
  public let instruction: String

    public init(){
    self.title = NSLocalizedString("Event_VitaminCCare_Title", comment: "")
    self.instruction = NSLocalizedString("Event_VitaminCCare_Content", comment: "")
  }
  public func asEventType() -> EventType {
    return .vitaminC(self)
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
      notification.push(notification: SimpleNotificationModel(title: locTitle, body: instruction, repeatCount: 1, fireDate: Date().addingTimeInterval(600), eventType: .vitaminC(VitaminCEvent())), badge: 1)
    }
  }
  public func getName() -> String {
    return "VitaminCEvent"
  }
}
