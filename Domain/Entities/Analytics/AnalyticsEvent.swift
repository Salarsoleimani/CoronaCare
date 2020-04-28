//
//  AnalyticsEventName.swift
//  CoronaCare
//
//  Created by Behrad Kazemi on 3/23/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public enum AnalyticsEventName {
	public enum Ads: String {
		case PresentAd = "Ads / Presenting Ads"
		case AdNotReady = "Ads / Ad not ready"
	}
	
	public enum Counter: String {
		case Feature = "Counter / Feature"
		case Scrolling = "Counter / Scrolling"
		case SocialMedia = "Counter / SocialMedia"
		case BedTime = "Counter / BedTime"
	}
	
	public enum Config: String {
		case SafetyLevel = "Config / SafetyLevel"
		case Language = "Config / Language"
	}
}

