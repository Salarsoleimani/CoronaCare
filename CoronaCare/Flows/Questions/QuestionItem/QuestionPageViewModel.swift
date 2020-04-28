//
//  QuestionPageViewModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/12/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain

final class QuestionPageViewModel {
  var models: [QuestionViewModel]
  let dataBase: DataBaseManagerInterface
    let navigator: QuestionNavigator
  
  init(models: [QuestionViewModel], dataBase: DataBaseManagerInterface, navigator: QuestionNavigator) {
    self.navigator = navigator
    self.dataBase = dataBase
    self.models = models
  }
  
  func setAnswer(answer: AnswerType, forViewModel viewModel: QuestionViewModel){
    dataBase.set(answer: answer, notificationId: viewModel.notificationID, completion: { [ viewModel] (updated) in
      
    }) { (error) in

    }
  }
}
