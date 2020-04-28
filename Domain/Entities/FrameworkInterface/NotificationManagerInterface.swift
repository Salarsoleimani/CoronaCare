//
//  NotificationManagerInterface.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/6/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public protocol NotificationManagerInterface: ResetableFrameworkProtocol, PushNotificationInterface {
//  static var shared: NotificationManagerInterface { get }
  func set(event: EventProtocol, configuration: ScheduledNotificationConfigModel)
  func remove(event: EventProtocol)
  func upNextNotifications(forEvent event: EventProtocol, response: @escaping ([SimpleNotificationModel]) -> Void)
}
