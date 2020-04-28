//
//  NotificationLogModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/8/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct NotificationLogModel {
  public let title: String
  public let repeatCount: Int16
  public let body: String
  public let fireDate: Date
  public let eventId: EventId
  public let status: AnswerType
  public let id: String
  public init(title: String, body: String, fireDate: Date, eventId: EventId, status: AnswerType, id: String, repeatCount: Int16) {
    self.title = title
    self.eventId = eventId
    self.body = body
    self.fireDate = fireDate
    self.status = status
    self.id = id
    self.repeatCount = repeatCount
  }
}
