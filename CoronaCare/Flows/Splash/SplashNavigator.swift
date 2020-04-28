//
//  SplashNavigator.swift
//
//  Created by Behrad Kazemi on 12/29/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import UIKit
import Hero
import CoreDataPlatform
import Permission

final class SplashNavigator: Navigator {
	func setup() {
		let splashVC = SplashViewController(nibName: "SplashViewController", bundle: nil)
		splashVC.viewModel = SplashViewModel(navigator: self)
		navigationController.viewControllers = [splashVC]
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
	}
  func toLocationPermission(_ permission: Permission) {
    let locationPermissionNavigator = LocationPermissionNavigator(navigationController: navigationController)
    locationPermissionNavigator.setup(permission)
  }
  func toNotificationPermission(_ permission: Permission) {
    let notifPermissionNavigator = NotificationPermissionNavigator(navigationController: navigationController)
    notifPermissionNavigator.setup(permission)
  }
	func toOnboarding() {
		Application.shared.run()
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		let onboardingNavigator = OnboardingNavigator(navigationController: navigationController)
		onboardingNavigator.setup()
	}
	
	func toHomeWithAds() {
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		toTabbar()
	}
	
	func toQuestions() {
		QuestionNavigator(navigationController: navigationController, dataBase: DatabaseManager.shared).setup(errorHandler: { [toHomeWithAds] error in
			toHomeWithAds()
		})
	}
}
