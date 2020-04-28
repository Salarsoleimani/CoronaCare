//
//  VersionNetworkModel.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-18.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct VersionNetworkModel: Decodable {
  public let min: Int
  public let max: Int
  public let currentVersion: String
  public let url: String
}
