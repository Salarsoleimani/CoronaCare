//
//  HomeNetworkModel.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

struct HomeNetworkModel: Decodable {
  public let title: String
  public var description: String
  public let headline: String
  public let src: String
  public let type: MediaType
  public let thumbnail: String
  public let id: Int
}
