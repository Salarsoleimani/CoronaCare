//
//  LocationLogModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/7/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct LocationLogModel {
  public let id: String?
  public let latitude: Double
  public let longitude: Double
  public let date: Date?
  public init(id: String?, latitude: Double, longitude: Double, date: Date?) {
    self.id = id
    self.latitude = latitude
    self.longitude = longitude
    self.date = date
  }
}
