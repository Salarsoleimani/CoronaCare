//
//  EventType.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public enum EventType: Decodable {
  case hands(HandsCareEvent)
  case vitaminC(VitaminCEvent)
  case mask(MaskEquipmentEvent)
  case gloves(GlovesEquipmentEvent)
  case sanitizing(SanitizingEvent)
  case drinkingWater(DrinkingWaterEvent)
  case deepBreath(DeepBreathingEvent)
  case meditation(MeditationEvent)
  
  case answerReminder(AnswerReminderEvent)
  case custom(CustomEvent)
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    
    if let element = try? container.decode(HandsCareEvent.self) {
      self = .hands(element)
      return
    }
    if let element = try? container.decode(VitaminCEvent.self) {
      self = .vitaminC(element)
      return
    }
    if let element = try? container.decode(MaskEquipmentEvent.self) {
      self = .mask(element)
      return
    }
    if let element = try? container.decode(GlovesEquipmentEvent.self) {
      self = .gloves(element)
      return
    }
    if let element = try? container.decode(SanitizingEvent.self) {
      self = .sanitizing(element)
      return
    }
    if let element = try? container.decode(DeepBreathingEvent.self) {
      self = .deepBreath(element)
      return
    }
    if let element = try? container.decode(DrinkingWaterEvent.self) {
      self = .drinkingWater(element)
      return
    }
    if let element = try? container.decode(MeditationEvent.self) {
      self = .meditation(element)
      return
    }
    if let element = try? container.decode(AnswerReminderEvent.self) {
      self = .answerReminder(element)
      return
    }
    if let element = try? container.decode(CustomEvent.self) {
      self = .custom(element)
      return
    }
    throw DecodingError.typeMismatch(EventType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for EventType"))
  }
  
  public func asEventProtocol() -> EventProtocol {
    var event: EventProtocol
    switch self {
    case let .hands(model):
      event = model
      break
    case let .vitaminC(model):
      event = model
      break
    case let .mask(model):
      event = model
      break
    case let .gloves(model):
      event = model
      break
    case let .sanitizing(model):
      event = model
      break
    case let .drinkingWater(model):
      event = model
      break
    case let .meditation(model):
      event = model
      break
    case let .deepBreath(model):
      event = model
      break
      
    case let .answerReminder(model):
      event = model
      break
    case let .custom(model):
      event = model
      break
    }
    return event
  }
}
extension EventType {
  public static func == (lhs: EventType, rhs: EventType) -> Bool {
    return lhs.asEventProtocol().id == rhs.asEventProtocol().id
  }
}
