//
//  RegionModel.swift
//  LocationManager
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import CoreLocation
public final class RegionModel {
	public static let defaultRegionRadius = 150.0
  public private(set) var currentState: RegionStateType?
  public var region: CLCircularRegion
  public init(withCenter center: CLLocationCoordinate2D, radiusInMeter radius: Double){
    self.region = CLCircularRegion(center: center, radius: radius, identifier: UUID().uuidString)
  }
  
  public init(withRegion model: CLCircularRegion){
    self.region = model
  }
  
  public func updateState(forCoordinate coordinate: CLLocationCoordinate2D) -> Bool {
		
    let newState = region.contains(coordinate) ? RegionStateType.inside : .outside
    if currentState == nil {
      currentState = newState
      return false
    }
    let didUpdate = currentState != newState
    currentState = newState
    return didUpdate
  }
  
  public func update(state: RegionStateType){
    currentState = state
  }
}

extension RegionModel: Equatable{
  public static func == (lhs: RegionModel, rhs: RegionModel) -> Bool {
    return lhs.region.center.latitude == rhs.region.center.latitude && lhs.region.radius == rhs.region.radius && lhs.region.center.longitude == rhs.region.center.longitude
  }
}
