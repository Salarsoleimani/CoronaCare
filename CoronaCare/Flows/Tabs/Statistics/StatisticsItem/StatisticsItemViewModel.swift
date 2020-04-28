//
//  StatisticsItemViewModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/12/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Domain
import Foundation
struct StatisticsItemViewModel {
  let title: String
  let progress: Float
  let model: StatisticsModel
  let qoute: String
  let color: SColor
  let eventState: StatResultEnum
  init(model: StatisticsModel) {
    self.model = model
    self.title = model.title
    self.progress = model.progress
    self.qoute = StatisticsItemViewModel.makeRandomQuote(forProgress: model.progress)
    self.eventState = StatisticsItemViewModel.getState(forProgress: self.progress)
    self.color = self.eventState.asSColor()
  }
  static func makeRandomQuote(forProgress progress: Float) -> String {
    let random = Int.random(in: 0..<6)

    let state = StatisticsItemViewModel.getState(forProgress: progress)
    let result = "Statistics_\(state.rawValue)_Quote_\(random)"
    return result.localiz()
  }
  static func getState(forProgress progress: Float) -> StatResultEnum {
    let state: StatResultEnum
    if progress >= 0.87 {
      state = .perfect
    }else if progress < 0.49 {
      state = .low
    }else {
      state = .medium
    }
    return state
  }
  
  static func randomValue() -> StatisticsItemViewModel {
    let models = SafetyLevel.makeEvents(.veryHigh)().compactMap{$0.asEventProtocol()}
    return StatisticsItemViewModel(model: StatisticsModel(model: models.randomElement() ?? HandsCareEvent(), progress: Float.random(in: 0..<1)))
  }
}
enum StatResultEnum: String {
  case low = "low"
  case medium = "medium"
  case perfect = "perfect"
  func asSColor() -> SColor{
    switch self {
    case .low:
      return SColor.red
    case .medium:
      return SColor.orange
    default:
      return SColor.green
    }
  }
}

