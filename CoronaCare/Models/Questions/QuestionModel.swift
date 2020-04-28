//
//  QuestionModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/3/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain
struct QuestionModel {
  let nofiticationId: String
  let question: String
  let event: EventType
  let options: [QuestionOptionModel]
  init(notificationId: String, question: String, options: [QuestionOptionModel], event: EventType) {
    self.nofiticationId = notificationId
    self.question = question
    self.options = options
    self.event = event
  }
  static let defaultModel = { return VitaminCEvent().makeQuestion(withNotificationId: "Error")}()
}
