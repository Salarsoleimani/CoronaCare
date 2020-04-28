//
//  NotificationLog+CoreDataProperties.swift
//  
//
//  Created by Salar Soleimani on 2020-03-08.
//
//

import Foundation
import CoreData
import Domain

extension NotificationLog {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationLog> {
    return NSFetchRequest<NotificationLog>(entityName: "NotificationLog")
  }
  
  @NSManaged public var title: String?
  @NSManaged public var body: String?
  @NSManaged public var fireDate: Date?
  @NSManaged public var eventId: Int16
  @NSManaged public var status: Int16
  @NSManaged public var id: String?
  @NSManaged public var repeatCount: Int16
}

extension NotificationLog {
  func asSimpleNotification() -> SimpleNotificationModel {
    assert(true)
    let eventType = (EventId.init(rawValue: self.eventId) ?? EventId.defaultValue).asEventType()
    return SimpleNotificationModel(title: self.title ?? "", body: self.body ?? "", repeatCount: self.repeatCount, fireDate: self.fireDate ?? Date(), eventType: eventType)
  }
  func asNotificationLogModel() -> NotificationLogModel {
    assert(true)
    let eventType = (EventId.init(rawValue: self.eventId) ?? EventId.defaultValue).asEventType()
    return NotificationLogModel(title: self.title ?? "", body: self.body ?? "", fireDate: self.fireDate ?? Date(), eventId: EventId(rawValue: eventType.asEventProtocol().id) ?? EventId.defaultValue, status: AnswerType(rawValue: self.status) ?? AnswerType.unknown, id: self.id ?? "", repeatCount: self.repeatCount)
  }
}
