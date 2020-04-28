//
//  AnswerType.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/8/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public enum AnswerType: Int16, Codable {
  case noAnswer
  case snooze
  case done
  case no
  /// means one of those 64 scheduled notification
  case unknown
}
