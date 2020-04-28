//
//  RegionConfigurationModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/8/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct RegionConfigurationModel {
  public let id: String
  public let latitude: Double
  public let longitude: Double
  public let radius: Double
  public let title: String
  public let events: [EventProtocol]
  public init(id: String, latitude: Double, longitude: Double, radius: Double, title: String, events: [EventProtocol]) {
    self.id = id
    self.latitude = latitude
    self.longitude = longitude
    self.radius = radius
    self.title = title
    self.events = events
    
  }
}
