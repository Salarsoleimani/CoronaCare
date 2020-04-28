//
//  UserInfoModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/8/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct UserInfoModel {
  public var sleepTime: String?
  public var wakeupTime: String?
  public let languageId: LanguageId
  public let saftyLevel: SafetyLevel
  public init(sleeptime: String?, wakeupTime: String?, languageId: Int16, saftyLevel: Int16) {
    self.sleepTime = sleeptime
    self.wakeupTime = wakeupTime
    self.languageId = LanguageId(rawValue: languageId) ?? LanguageId.defaultValue
    self.saftyLevel = SafetyLevel(rawValue: saftyLevel) ?? SafetyLevel.defaultLevel
  }
}
