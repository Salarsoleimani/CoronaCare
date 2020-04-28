//
//  OnboardingNavigator.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/26/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import CBFlashyTabBarController
import Permission
import CoreDataPlatform
import AnalyticPlatform

final class OnboardingNavigator: Navigator {
  func setup() {
    let vc = OnboardingViewController(navigator: self)
		navigationController.interactivePopGestureRecognizer?.isEnabled = false
    navigationController.pushViewController(vc, animated: false)
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
  }
  func toPermissions() {
		navigationController.interactivePopGestureRecognizer?.isEnabled = true
    AppAnalytics.shared.setOboardingWatched()
    
    let locPermission = Permission.locationAlways
    let notifPermission = Permission.notifications

    if locPermission.status != .authorized {
      let locPermissionNavigator = LocationPermissionNavigator(navigationController: navigationController)
      locPermissionNavigator.setup(locPermission)
    } else if notifPermission.status != .authorized {
      let notifPermissionNavigator = NotificationPermissionNavigator(navigationController: navigationController)
      notifPermissionNavigator.setup(notifPermission)
    } else {
      toTabbar()
    }
  }
}
