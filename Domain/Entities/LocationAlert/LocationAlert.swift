//
//  LocationAlert.swift
//  LocationManager
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public final class LocationAlert {
  public let id = UUID().uuidString
  public var tasks: [LocationAlertTask]
  public var region: RegionModel
  public init(tasks: [LocationAlertTask], region: RegionModel){
    self.tasks = tasks
    self.region = region
  }
  
  public func fire(eventType: LocationAlertType) {
    tasks.forEach { (task) in
      task.execute(type: eventType)
    }
  }
}

extension LocationAlert: Equatable {
  public static func == (lhs: LocationAlert, rhs: LocationAlert) -> Bool {
    return lhs.region == rhs.region
  }
}
