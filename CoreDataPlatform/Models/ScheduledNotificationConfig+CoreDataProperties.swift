//
//  ScheduledNotificationConfig+CoreDataProperties.swift
//  
//
//  Created by Salar Soleimani on 2020-03-08.
//
//

import Foundation
import CoreData


extension ScheduledNotificationConfig {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduledNotificationConfig> {
        return NSFetchRequest<ScheduledNotificationConfig>(entityName: "ScheduledNotificationConfig")
    }

    @NSManaged public var eventId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var cycleTime: Double
    @NSManaged public var repeatCount: Int16

}
