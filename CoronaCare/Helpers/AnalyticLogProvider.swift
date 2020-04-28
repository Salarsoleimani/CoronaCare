//
//  AnalyticLogProvider.swift
//  CoronaCare
//
//  Created by Behrad Kazemi on 3/23/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import AnalyticPlatform
import Domain

final class AnalyticLogProvider {
	var logged = false
	static func logNavigator(name: String, functionName: String){
		let type = AnalyticsEventName.Counter.Feature
		let parameter = ["type": "Navigator",
										 "host": name,
										 "function" : "\(functionName)()"]
		
		AppAnalytics.shared.log(eventName: type.rawValue, parameters: parameter)
	}
	
	static func logAdsInNavigator(hostName: String, functionName: String, status: Bool){
		let type = status ? AnalyticsEventName.Ads.PresentAd.rawValue : AnalyticsEventName.Ads.AdNotReady.rawValue
		let parameter = ["type": "Navigator",
										 "host": hostName,
										 "function" : "\(functionName)()"]
		
		AppAnalytics.shared.log(eventName: type, parameters: parameter)
	}
	
	static func logLanguageType(hostName: String, functionName: String, languageType: LanguageId){
		let type = AnalyticsEventName.Config.Language.rawValue
		let parameter = ["type": "\(languageType.asStringName())",
										 "host": hostName,
										 "function" : "\(functionName)()"]
		
		AppAnalytics.shared.log(eventName: type, parameters: parameter)
	}
	
	static func logSocialMedia(hostName: String, functionName: String, site: String){
		let type = AnalyticsEventName.Counter.SocialMedia.rawValue
		let parameter = ["type": site,
										 "host": hostName,
										 "function" : "\(functionName)()"]
		
		AppAnalytics.shared.log(eventName: type, parameters: parameter)
	}
	
	static func logBedTime(hostName: String, functionName: String, wakeTime: String, sleepTime: String){
		let wakeInDouble = Date.stringTimeToDouble(timeString: wakeTime)
		let bedInDouble = Date.stringTimeToDouble(timeString: sleepTime)
		let type = AnalyticsEventName.Counter.BedTime.rawValue
		let parameter = ["type": "Navigator",
										 "host": hostName,
										 "wake": wakeInDouble,
										 "sleep": bedInDouble,
										 "function" : "\(functionName)()"] as [String : Any]
		
		AppAnalytics.shared.log(eventName: type, parameters: parameter)
	}
	
	static func logSafetyLevel(hostName: String, safetyLevel: SafetyLevel, functionName: String){
		let type = AnalyticsEventName.Config.SafetyLevel.rawValue
		let parameter = ["level": "\(safetyLevel.rawValue)",
										 "host": hostName,
										 "function" : "\(functionName)()"]
		
		AppAnalytics.shared.log(eventName: type, parameters: parameter)
	}
	func logScrollingVisit(hostName: String, scrollName: String, offset: Float, contentSize: Float){
		let type = AnalyticsEventName.Counter.Scrolling.rawValue
		let parameter = ["type": "ViewController",
										 "host": hostName,
										 "Scrolling" : "\(scrollName)()"]
		if offset >= contentSize - 50, !logged {
			logged = true
			AppAnalytics.shared.log(eventName: type, parameters: parameter)
		}
	}
}
