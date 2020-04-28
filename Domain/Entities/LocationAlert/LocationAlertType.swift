//
//  LocationAlertType.swift
//  LocationManager
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public enum LocationAlertType: Int , Codable{
  /// If there is no location alert
  case unknown
  case entering
  case exiting
  case both
}
