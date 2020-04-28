//
//  LocationLog+CoreDataProperties.swift
//  
//
//  Created by Salar Soleimani on 2020-03-08.
//
//

import Foundation
import CoreData
import Domain

extension LocationLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationLog> {
        return NSFetchRequest<LocationLog>(entityName: "LocationLog")
    }

    @NSManaged public var id: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date?

}

extension LocationLog {
  func asLocationLogModel() -> LocationLogModel {
    return LocationLogModel(id: self.id, latitude: self.latitude, longitude: self.longitude, date: self.date)
  }
}
