//
//  QuestionViewModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/27/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain
final class QuestionViewModel {
  
  let model: QuestionModel
  
  let imageName: String
  let title: String
  let acceptButtonTitle: String
  let ignoreButtonTitle: String
  
  let notificationID: String
  
  init(model: QuestionModel) {
    
    self.imageName = model.event.getImageName()
    self.model = model
    self.notificationID = model.nofiticationId
    self.title = model.question
    self.acceptButtonTitle = model.options.first?.title ?? "Default_Question_Accept_Button".localiz()
    self.ignoreButtonTitle = model.options.last?.title ?? "Default_Question_Ignore_Button".localiz()
  }
}

extension EventType {
  func getImageName() -> String {
    switch self {
    case .hands(_):
      return "screen 3"
    case .vitaminC(_):
      return "screen 6"
    case .mask(_):
      return "screen 4"
    case .gloves(_):
      return "Questions_Gloves"
    case .sanitizing(_):
      return "screen 7"
    case .drinkingWater(_):
      return "screen 3" // [TODO] -force
    case .meditation(_):
      return "screen 3" // [TODO] -force
    case .deepBreath(_):
      return "screen 3" // [TODO] -force
    case .answerReminder(_):
      return "screen 3" // [TODO] -force
    case .custom(_):
      return "screen 3" // [TODO] -force
    }
  }
}
