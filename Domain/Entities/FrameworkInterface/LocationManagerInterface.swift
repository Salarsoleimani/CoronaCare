//
//  LocationManagerInterface.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/6/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation
public protocol LocationManagerInterface: ResetableFrameworkProtocol {

	func setDelegate(dataBaseDelegate: DataBaseManagerInterface?, appEngineDelegate: AppEngineLocationDelegate?)
  var alerts: [LocationAlert] { get }
  func set(alert: LocationAlert) throws
  func getCurrentRegion(withRadiusInMeter radius: Double) throws -> RegionModel
  func getCurrentLocation() -> CLLocation?
  func refresh()
  
}
