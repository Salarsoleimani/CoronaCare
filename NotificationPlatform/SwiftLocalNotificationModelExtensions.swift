//
//  SwiftLocalNotificationModelExtensions.swift
//  NotificationPlatform
//
//  Created by Salar Soleimani on 2020-04-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import SwiftLocalNotification
import Domain

extension SwiftLocalNotificationModel {
  func asSimpleNotificationModel() -> SimpleNotificationModel {
    let eventId = EventId(rawValue: Int16(category ?? "0") ?? EventId.defaultValue.rawValue) ?? EventId.defaultValue
    return SimpleNotificationModel(title: self.title ?? "", body: self.body ?? "", repeatCount: 1, fireDate: self.fireDate ?? Date(), eventType: eventId.asEventType())
  }
}
