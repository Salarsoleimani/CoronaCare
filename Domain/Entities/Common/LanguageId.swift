//
//  LanguageId.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-03-27.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public enum LanguageId: Int16 {
  case EN, IR, CH
   public static let defaultValue = LanguageId.EN
}

extension LanguageId {
  public func asStringName() -> String {
    switch self {
    case .EN:
      return "English"
    case .IR:
      return "فارسی"
    case .CH:
      return "中文"
    }
  }
}
