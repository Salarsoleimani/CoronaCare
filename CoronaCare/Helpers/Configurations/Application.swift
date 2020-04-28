//
//  Application.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-28.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Domain
import Siren
import AppEngine
import SwiftRater
import GoogleMobileAds
import AnalyticPlatform
import CBFlashyTabBarController
import BackgroundHandler
final class Application {
  static let shared = Application()

  let notificationDelegate: NotificationDelegate
  let backgroundHandler = BackgroundHandler.shared
  
  private init() {
    
    AppAnalytics.shared.setup()
		
    self.notificationDelegate = NotificationDelegate()
  }
  
  func configureMainInterface(in window: UIWindow) {
		CBFlashyTabBar.appearance().tintColor = .red
    LanguageManager.shared.defaultLanguage = .deviceLanguage

    let mainNavigationController = MainNavigationController()
    window.rootViewController = mainNavigationController
    window.makeKeyAndVisible()
    SplashNavigator(navigationController: mainNavigationController).setup()
  }
  
  func setupApplicationConfigurations() {
    setupNotificationDelegate()
    setupRateManager()
    setupUpdateManager()
		setupBackgroundTasks()
    resetNotificationBadge()
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["72ef0c1b55cbe0034f0d1a5fd0fca1df"]
  }

  func run() {
    AppEngine.shared.runIfNeeded(id: "Application")
  }
	
	func setupBackgroundTasks() {
		backgroundHandler.registerTasks()
	}
	func refresh() {
		AppEngine.shared.refreshLocation()
	}
	func scheduleBackgroundTasks() {
		AppEngine.shared.refresh()
		backgroundHandler.scheduleTasks()
	}
	
  private func setupUpdateManager() {
    Siren.shared.wail()
    Siren.shared.rulesManager = RulesManager(majorUpdateRules: Rules(promptFrequency: .immediately, forAlertType: .force), minorUpdateRules: Rules(promptFrequency: .daily, forAlertType: .option), patchUpdateRules: Rules(promptFrequency: .weekly, forAlertType: .skip), revisionUpdateRules: Rules.default, showAlertAfterCurrentVersionHasBeenReleasedForDays: 3)
  }
  private func resetNotificationBadge() {
    UIApplication.shared.applicationIconBadgeNumber = 0
  }
  private func setupNotificationDelegate() {
    notificationDelegate.notificationCenter.delegate = notificationDelegate
  }
  private func setupRateManager() {
    SwiftRater.alertCancelTitle = "Rate_alertCancelTitle".localiz()
    SwiftRater.alertMessage = "Rate_alertMessage".localiz()
    SwiftRater.alertRateLaterTitle = "Rate_alertRateLaterTitle".localiz()
    SwiftRater.alertRateTitle = "Rate_alertRateTitle".localiz()
    SwiftRater.alertTitle = "Rate_alertTitle".localiz()
    
    SwiftRater.daysUntilPrompt = 2
    SwiftRater.usesUntilPrompt = 10
    SwiftRater.significantUsesUntilPrompt = 3
    SwiftRater.daysBeforeReminding = 1
    SwiftRater.showLaterButton = true
    SwiftRater.debugMode = true
    SwiftRater.appLaunched()
  }
  
}
