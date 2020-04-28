//
//  Extensions.swift
//  CoreDataPlatform
//
//  Created by Salar Soleimani on 2020-03-08.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Domain
import CoreData
//import AnalyticPlatform

public class DatabaseManager: DataBaseManagerInterface {

  
  private(set) lazy var userInfoDB = SasCoreData<UserInfo>()
  private(set) lazy var notificationLogDB = SasCoreData<NotificationLog>()
  private(set) lazy var locationLogDB = SasCoreData<LocationLog>()
  private(set) lazy var scheduledNotificationConfigDB = SasCoreData<ScheduledNotificationConfig>()
  private(set) lazy var regionConfigurationDB = SasCoreData<RegionConfiguration>()
  
  public static var shared: DataBaseManagerInterface = {
    return DatabaseManager()
  }()
  
  public func getNotificationModels(forEvent event: EventProtocol, response: ([SimpleNotificationModel]) -> Void, error: (Error) -> Void) {
    let predicate = NSPredicate(format: "eventId == %d", event.id)
    notificationLogDB.getAll(predicate: predicate) { [response, error] (result) in
      switch result {
      case .success(let resp):
        response(resp.compactMap{$0.asSimpleNotification()})
      case .failure(let err):
        error(err)
      }
    }
  }
  
  public func getNotificationLogs(forAnswerType type: AnswerType, beforeDate: Date, response: ([NotificationLogModel]) -> Void, error: (Error) -> Void) {
		
    let predicate = NSPredicate(format: "status == %d AND fireDate <= %@", type.rawValue, beforeDate as NSDate)
    notificationLogDB.getAll(predicate: predicate) { [response, error] (result) in
      switch result {
      case .success(let resp):
        response(resp.compactMap{$0.asNotificationLogModel()})
      case .failure(let err):
        error(err)
      }
    }
  }
  public func getRegionConfigurations(response: ([RegionConfigurationModel]) -> Void, error: (Error) -> Void) {
    regionConfigurationDB.getAll(predicate: nil) { [response, error] (result) in
      switch result {
      case .success(let resp):
        response(resp.compactMap{$0.asRegionConfigurationModel()})
      case .failure(let err):
        error(err)
      }
    }
  }
  
  
  public func getLocationLogs(withPrediction prediction: NSPredicate?, response: ([LocationLogModel]) -> Void, error: (Error) -> Void) {
    let dateSort = NSSortDescriptor(key: "date", ascending: false)
    locationLogDB.getAll(predicate: prediction, sortDescriptor: dateSort) {[response, error] (result) in
      switch result {
      case .success(let resp):
        response(resp.compactMap{$0.asLocationLogModel()})
      case .failure(let err):
        error(err)
      }
    }
  }
  
  public func getUserInfo(response: (UserInfoModel) -> Void, error: (Error) -> Void) {
    userInfoDB.getAll(predicate: nil) {[response, error] (result) in
      switch result {
      case .success(let resp):
        let respModels = resp.compactMap{$0.asUserInfoModel()}
        if let safeResp = respModels.first {
          response(safeResp)
        }
      case .failure(let err):
        error(err)
      }
    }
  }
  
  public func add(regionConfig: RegionConfigurationModel, completion: ((Bool) -> Void)?) {
    let regConfig = NSEntityDescription.insertNewObject(forEntityName: "RegionConfiguration", into: regionConfigurationDB.persistentContainer.viewContext) as! RegionConfiguration
    regConfig.setValue(regionConfig.id, forKey: "id")
    regConfig.setValue(regionConfig.latitude, forKey: "latitude")
    regConfig.setValue(regionConfig.longitude, forKey: "longitude")
    regConfig.setValue(regionConfig.radius, forKey: "radius")
    regConfig.setValue(regionConfig.title, forKey: "title")
    regConfig.setValue(Int16s.init(arrayOfInt: regionConfig.events.compactMap{$0.id}), forKey: "events")
    
    regionConfigurationDB.add(regConfig) { (updated) in
      if completion != nil {
        completion!(updated)
      }
    }
  }
  public func set(answer: AnswerType, notificationId: String, completion: ((Bool) -> Void)?, error: (Error) -> Void) {
    let predicate = NSPredicate(format: "id == %@", notificationId)
    notificationLogDB.getAll(predicate: predicate) {[completion, error] (result) in
      switch result {
      case .success(let allNotifs):
        allNotifs.forEach { (notif) in
          notif.status = Int16(answer.rawValue)
          self.notificationLogDB.update(notif) {[/*manager = AppAnalytics.shared,*/ completion] (completed) in
//            manager.log(eventName: "question_answered", parameters: ["questionEvent": notif.asSimpleNotification().eventType.asEventProtocol().getName(), "questionAnswer": answer.rawValue])
            if completion != nil {
              completion!(completed)
            }
          }
        }
      case .failure(let err):
        error(err)
      }
    }
  }
  
  public func update(RegionConfiguration configuration: RegionConfigurationModel, completion: ((Bool) -> Void)?, error: (Error) -> Void) {
    regionConfigurationDB.getAll(predicate: nil) {[completion, error] (result) in
      switch result {
      case .success(let allRegionConfigurations):
        allRegionConfigurations.forEach { (regConfig) in
          regConfig.events = Int16s.init(arrayOfInt: configuration.events.compactMap{$0.id})
          regConfig.latitude = configuration.latitude
          regConfig.longitude = configuration.longitude
          regConfig.radius = configuration.radius
          regConfig.title = configuration.title
          self.regionConfigurationDB.update(regConfig) {[completion] (completed) in
            if completion != nil {
              completion!(completed)
            }
          }
        }
      case .failure(let err):
        error(err)
      }
    }
  }
  
  public func update(UserInfo info: UserInfoModel, completion: ((Bool) -> Void)?, error: (Error) -> Void) {
    userInfoDB.getAll(predicate: nil) {[completion, error] (result) in
      switch result {
      case .success(let userInfo):
        userInfo.forEach { (userInfo) in
          userInfo.languageId = info.languageId.rawValue
          userInfo.saftyLevel = info.saftyLevel.rawValue
          userInfo.sleepTime = info.sleepTime
          userInfo.wakeupTime = info.wakeupTime
          self.userInfoDB.update(userInfo) {[completion] (completed) in
            if completion != nil {
              completion!(completed)
            }
          }
        }
      case .failure(let err):
        if err == .isEmpty {
          let dbUserInfo = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: userInfoDB.persistentContainer.viewContext) as! UserInfo
          dbUserInfo.setValue(info.languageId.rawValue, forKey: "languageId")
          dbUserInfo.setValue(info.saftyLevel.rawValue, forKey: "saftyLevel")
          dbUserInfo.setValue(info.sleepTime, forKey: "sleepTime")
          dbUserInfo.setValue(info.wakeupTime, forKey: "wakeupTime")
          userInfoDB.add(dbUserInfo) { (updated) in
            print("new user info added: \(updated)")
          }
        }
        error(err)
      }
    }
  }
  
  public func log(Location location: LocationLogModel, completion: ((Bool) -> Void)?) {
    let locationLog = NSEntityDescription.insertNewObject(forEntityName: "LocationLog", into: locationLogDB.persistentContainer.viewContext) as! LocationLog
    locationLog.setValue(location.latitude, forKey: "latitude")
    locationLog.setValue(location.id, forKey: "id")
    locationLog.setValue(location.longitude, forKey: "longitude")
    locationLog.setValue(location.date, forKey: "date")
    
    locationLogDB.add(locationLog) {[completion] (completed) in
      if completion != nil {
        completion!(completed)
      }
    }
  }
  
  public func log(Notification notification: NotificationLogModel, completion: ((Bool) -> Void)?) {
    let notifLog = NSEntityDescription.insertNewObject(forEntityName: "NotificationLog", into: notificationLogDB.persistentContainer.viewContext) as! NotificationLog
    notifLog.setValue(notification.id, forKey: "id")
    notifLog.setValue(notification.body, forKey: "body")
    notifLog.setValue(notification.eventId.rawValue, forKey: "eventId")
    notifLog.setValue(notification.fireDate, forKey: "fireDate")
    notifLog.setValue(notification.status.rawValue, forKey: "status")
    notifLog.setValue(notification.title, forKey: "title")
    notifLog.setValue(notification.repeatCount, forKey: "repeatCount")

    notificationLogDB.add(notifLog) { (completed) in
      if completion != nil {
        completion!(completed)
      }
    }
  }
  
  public func getStatistics(response: ([StatisticsModel]) -> Void, error: (Error) -> Void) {
		let predicate = NSPredicate(format: "(status == %d) OR (status == %d) OR (status == %d)", AnswerType.no.rawValue, AnswerType.noAnswer.rawValue, AnswerType.done.rawValue )
    notificationLogDB.getAll(predicate: predicate) { [response, error] (result) in
      switch result {
      case .success(let resp):
        
        let events = resp.compactMap{$0.asSimpleNotification().eventType}
        let distinctEvents = events.unique{$0.asEventProtocol().id}
//        let distinctEvents = events.compactMap { (item) -> EventType? in
//          if events.contains(where: { [item] (previousItem) -> Bool in
//            previousItem == item
//          }){
//            return nil
//          }
//          return item
//        }
        let statitics = distinctEvents.compactMap { [resp](item) -> StatisticsModel in
          let currentNotifications = resp.filter { [item](logItem) -> Bool in
            return logItem.eventId == item.asEventProtocol().id
          }
          let yesCount = currentNotifications.filter { (logItem) -> Bool in
            logItem.status == AnswerType.done.rawValue
          }.count
          let total = currentNotifications.count == 0 ? 1 : currentNotifications.count
          let progress = Float(yesCount) / Float(total)
          return StatisticsModel(model: item.asEventProtocol(), progress: progress)
        }
        response(statitics)
      case .failure(let err):
        error(err)
      }
    }
  }
  public func delete(NotificationIds notificationIds: [String], completion: ((Bool) -> Void)?) {
    let predicate = NSPredicate(format: "ANY id IN %@", notificationIds)
    notificationLogDB.batchDelete(predicate: predicate) { (updated) in
      if completion != nil {
        completion!(updated)
      }
    }
  }
  public func resetFactory() {
    notificationLogDB.deleteAllRecords()
    locationLogDB.deleteAllRecords()
    scheduledNotificationConfigDB.deleteAllRecords()
    regionConfigurationDB.deleteAllRecords()
  }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
