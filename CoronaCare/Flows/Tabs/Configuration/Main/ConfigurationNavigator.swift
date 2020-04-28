//
//  ConfigurationNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-04.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Permission
import Domain

final class ConfigurationNavigator: Navigator {

  func setup() -> UIViewController {
    let vc = ConfigurationViewController(navigator: self)
    AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
    navigationController.pushViewController(vc, animated: true)
    return vc
  }
  func toLocationPermission(_ permission: Permission, configVC: ConfigurationViewController) {
    let locationPrivacyNavigator = LocationPermissionNavigator(navigationController: navigationController)
    locationPrivacyNavigator.setupFromConfiguration(permission, configVC: configVC)
  }
  func toNotificationPermission(_ permission: Permission, configVC: ConfigurationViewController) {
    let notifPrivacyNavigator = LocationPermissionNavigator(navigationController: navigationController)
    notifPrivacyNavigator.setupFromConfiguration(permission, configVC: configVC)
  }
  func toSleepTime(_ vc: ConfigurationViewController, userInfo: UserInfoModel?) {
    let sleepNavigator = SleepTimeNavigator(navigationController: navigationController)
    sleepNavigator.setup(vc, userInfo: userInfo)
  }
}
