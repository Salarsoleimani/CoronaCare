//
//  EventId.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-03-08.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public enum EventId: Int16 {
  case hands = 11
  case vitaminC = 22
  case gloves = 33
  case mask = 44
  case sanitizing = 55
  case drinkingWater = 66
  case meditation = 77
  case deepBreath = 88
  
  case answerQuestions = 98
  case customEvent = 99
  
  public func asEventType() -> EventType {
    switch self {
    case .hands:
      return HandsCareEvent().asEventType()
      
    case .vitaminC:
      return VitaminCEvent().asEventType()
      
    case .gloves:
      return GlovesEquipmentEvent().asEventType()
      
    case .mask:
      return MaskEquipmentEvent().asEventType()
      
    case .sanitizing:
      return SanitizingEvent().asEventType()
      
    case .drinkingWater:
      return DrinkingWaterEvent().asEventType()
      
    case .meditation:
      return MeditationEvent().asEventType()
      
    case .deepBreath:
      return DeepBreathingEvent().asEventType()
      
    case .answerQuestions:
      return AnswerReminderEvent().asEventType()
      
    case .customEvent:
      let event =  AnswerReminderEvent()//[TODO] -medium
      return CustomEvent(title: event.title, instruction: event.instruction).asEventType()
    }
  }
  public static let defaultValue = EventId.hands
}
