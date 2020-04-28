//
//  PushNotificationInterface.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/9/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public protocol PushNotificationInterface {
  func push(notification: SimpleNotificationModel, badge: Int?)
}
