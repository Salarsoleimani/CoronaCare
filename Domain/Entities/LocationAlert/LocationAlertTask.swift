//
//  LocationAlertTask.swift
//  LocationManager
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public final class LocationAlertTask{
  public let condition: (LocationAlertType) -> Bool
  public let task: () -> ()
  
  
  public init(condition: @escaping (LocationAlertType) -> Bool, task: @escaping () -> ()){
    self.condition = condition
    self.task = task
  }
  
  func execute(type: LocationAlertType) {
    if condition(type) {
      task()
    }
  }
}
