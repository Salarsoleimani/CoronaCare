//
//  SimpleNotificationModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/6/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct SimpleNotificationModel: Decodable {
  public let id: String
  public let eventType: EventType
  public let title: String
  public let body: String
  public let repeatCount: Int16
  public var fireDate: Date
  
  public init(title: String, body: String, repeatCount: Int16, fireDate: Date, eventType: EventType) {
    self.id = UUID().uuidString
    self.title = title
    self.body = body
    self.repeatCount = repeatCount
    self.fireDate = fireDate
    self.eventType = eventType
  }
}
public extension SimpleNotificationModel {
  func asNotificationLog(answerStatus: AnswerType) -> NotificationLogModel {
    return NotificationLogModel(title: title, body: body, fireDate: fireDate, eventId: EventId(rawValue: eventType.asEventProtocol().id) ?? EventId.defaultValue, status: answerStatus, id: id, repeatCount: repeatCount)
  }
}
