//
//  CoreDataError.swift
//  CoreDataPlatform
//
//  Created by Behrad Kazemi on 3/17/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain

extension Error {
  func asCoreDataError() -> CoreDataError {
    let code = (self as NSError).code
    switch code {
    case 0:
      return .updateError
    case 1:
      return .addError
    case 2:
      return .deleteError
    case 3:
      return .isEmpty
    case 4:
      return .getError
    default:
      return .unknown
    }
  }
}
