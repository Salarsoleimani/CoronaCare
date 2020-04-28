//
//  StatisticsModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/12/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public struct StatisticsModel {
  public let model: EventProtocol
  public let progress: Float
  public let title: String
 public init(model: EventProtocol, progress: Float) {
    self.model = model
    self.progress = progress
    self.title = model.title
  }
}
