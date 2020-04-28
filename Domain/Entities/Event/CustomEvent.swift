//
//  CustomEvent.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/26/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public struct CustomEvent: EventProtocol {
  
  public let id = EventId.sanitizing.rawValue
  public let title: String
  public let instruction: String

	public init(title: String, instruction: String){
    self.title = title
    self.instruction = instruction
  }
  public func asEventType() -> EventType {
    return .custom(self)
  }
  public func makeConfig(forSafetyLevel level: SafetyLevel) -> ScheduledNotificationConfigModel? {
		return nil
  }
  public func makeLocationTask(notification: PushNotificationInterface) -> LocationAlertTask? {
    return nil
  }
  public func getName() -> String {
    return "CustomEvent"
  }
	
	
}

