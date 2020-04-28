//
//  StaticConstants.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-28.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit

struct StaticConstants {
  static let appOpenedCount: Int = UserDefaults.standard.integer(forKey: Constants.Keys.appOpenedCount.rawValue)
  static let watchedRewardedAdCount: Int = UserDefaults.standard.integer(forKey: Constants.Keys.watchedRewardAd.rawValue)
  static let watchedRewardedAdInQuestionCount: Int = UserDefaults.standard.integer(forKey: Constants.Keys.watchedRewardAdInQuestion.rawValue)
  static let isAdsRemoved: Bool = UserDefaults.standard.bool(forKey: Constants.Keys.removeAds.rawValue)
  static let isOnboardingWatched: Bool = UserDefaults.standard.bool(forKey: Constants.Keys.isOnboardingWatched.rawValue)

  static let snoozeMinutes: Int = UserDefaults.standard.integer(forKey: Constants.Keys.snoozeMinutes.rawValue) > 0 ? UserDefaults.standard.integer(forKey: Constants.Keys.snoozeMinutes.rawValue) : 2

  static let mainScreenWidth = UIScreen.main.bounds.width
  static let mainScreenHeight = UIScreen.main.bounds.height
}
