//
//  SafetyLevel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/5/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
public enum SafetyLevel: Int16, Codable {
	case basic
	case low
	case medium
	case high
	case veryHigh
	
	public func makeEvents() -> [EventType] {
		switch self {
		case .veryHigh:
			return [HandsCareEvent().asEventType(),
							GlovesEquipmentEvent().asEventType(),
							VitaminCEvent().asEventType(),
							MaskEquipmentEvent().asEventType(),
							SanitizingEvent().asEventType()]
		case .high:
			return [HandsCareEvent().asEventType(),
							GlovesEquipmentEvent().asEventType(),
							VitaminCEvent().asEventType(),
							MaskEquipmentEvent().asEventType(),
							SanitizingEvent().asEventType()]
		case .medium:
			return [HandsCareEvent().asEventType(),
							GlovesEquipmentEvent().asEventType(),
							MaskEquipmentEvent().asEventType()]
		case .low:
			return [HandsCareEvent().asEventType(),
							MaskEquipmentEvent().asEventType(),
							SanitizingEvent().asEventType()]
		case .basic:
			return [HandsCareEvent().asEventType(),SanitizingEvent().asEventType()]
		}
	}
	
	public static let defaultLevel = SafetyLevel.medium
}
