//
//  EventProtocol.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public protocol EventProtocol: Codable {
  var id: Int16 { get }
  var title: String { get }
  var instruction: String { get }
  func asEventType() -> EventType
  func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel?
  func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask?
  func getName() -> String
}
