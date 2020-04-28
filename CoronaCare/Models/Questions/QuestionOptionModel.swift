//
//  QuestionOptionModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
struct QuestionOptionModel {
  let id: String
  let title: String
  init(title: String) {
    self.title = title
    self.id = UUID().uuidString
  }
}
