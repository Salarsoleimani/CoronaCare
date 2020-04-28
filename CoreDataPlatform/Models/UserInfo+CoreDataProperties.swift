//
//  UserInfo+CoreDataProperties.swift
//  
//
//  Created by Salar Soleimani on 2020-03-08.
//
//

import Foundation
import CoreData
import Domain

extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var sleepTime: String?
    @NSManaged public var wakeupTime: String?
    @NSManaged public var languageId: Int16
    @NSManaged public var saftyLevel: Int16

}

extension UserInfo {
  func asUserInfoModel() -> UserInfoModel {
    return UserInfoModel(sleeptime: self.sleepTime, wakeupTime: self.wakeupTime, languageId: self.languageId, saftyLevel: self.saftyLevel)
  }
}
