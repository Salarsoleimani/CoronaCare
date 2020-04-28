//
//  EventProtocol+Question.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/6/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Domain

extension EventProtocol {
  func makeQuestion(withNotificationId notifId: String) -> QuestionModel {
    let type = self.asEventType()
    let options = [QuestionOptionModel]() //[TODO] provide custom options for each question.
    var question = ""
    switch type {
    case .hands(_):
      question = "Question_Title_Hands".localiz()
      break
    case .vitaminC(_):
      question = "Question_Title_VitaminC".localiz()
      break
    case .mask(_):
      question = "Question_Title_Mask".localiz()
      break
    case .gloves(_):
      question = "Question_Title_Gloves".localiz()
      break
    case .sanitizing(_):
      question = "Question_Title_Sanitizing".localiz()
      break
    case .deepBreath(_):
      question = "" // [TODO] -force
      break
    case .drinkingWater(_):
      question = "" // [TODO] -force
      break
    case .meditation(_):
      question = "" // [TODO] -force
      break
    case .answerReminder(_):
      question = ""
      break
    case .custom(_):
      question = ""
      break
    }
    return QuestionModel(notificationId: notifId, question: question, options: options, event: type)
  }
}
