//
//  DataBaseManagerInterface.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/6/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public protocol DataBaseManagerInterface: ResetableFrameworkProtocol {
  static var shared: DataBaseManagerInterface { get }
  func getNotificationModels(forEvent event: EventProtocol, response: ([SimpleNotificationModel]) -> Void, error: (Error) -> Void)
  func getNotificationLogs(forAnswerType type: AnswerType, beforeDate: Date, response: ([NotificationLogModel]) -> Void, error: (Error) -> Void)
  func getStatistics(response: ([StatisticsModel]) -> Void, error: (Error) -> Void)
  func getRegionConfigurations(response: ([RegionConfigurationModel]) -> Void, error: (Error) -> Void)
  func getLocationLogs(withPrediction prediction: NSPredicate?, response: ([LocationLogModel])-> Void, error: (Error) -> Void)
  func getUserInfo(response: (UserInfoModel) -> Void, error: (Error) -> Void)
  func add(regionConfig: RegionConfigurationModel, completion: ((Bool) -> Void)?)
  func set(answer: AnswerType, notificationId: String, completion: ((Bool) -> Void)?, error: (Error) -> Void)
  func update(RegionConfiguration configuration: RegionConfigurationModel, completion: ((Bool) -> Void)?, error: (Error) -> Void)
  func update(UserInfo info: UserInfoModel, completion: ((Bool) -> Void)?, error: (Error) -> Void)
  func log(Location location: LocationLogModel, completion: ((Bool) -> Void)?)
  func log(Notification notification: NotificationLogModel, completion: ((Bool) -> Void)?)
  
  func delete(NotificationIds notificationIds: [String], completion: ((Bool) -> Void)?)
}
