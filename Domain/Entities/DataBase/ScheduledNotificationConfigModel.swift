//
//  EventConfigurationModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/7/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct ScheduledNotificationConfigModel {
  public let eventId: Int16 //matched with EventProtocol's id
  public let scheduledCycleTime: Double //In munites
  public let repeatCount: UInt
  
  public init(eventId: Int16, scheduledCycleTime: Double, repeatCount: UInt){
    self.eventId = eventId
    self.scheduledCycleTime = scheduledCycleTime
    self.repeatCount = repeatCount
  }
  
  public static let defaultConfig = ScheduledNotificationConfigModel(eventId: EventId.defaultValue.rawValue, scheduledCycleTime: 360.0, repeatCount: 4)
}
