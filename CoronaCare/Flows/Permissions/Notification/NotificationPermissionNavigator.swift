//
//  NotificationPermissionNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-25.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import CBFlashyTabBarController
import Permission
import Domain
import CoreDataPlatform
import AnalyticPlatform
final class NotificationPermissionNavigator: Navigator {
  func setup(_ permission: Permission) {
    let vc = NotificationPermissionViewController(navigator: self, permission: permission)
    navigationController.pushViewController(vc, animated: true)
    navigationController.setNavigationBarHidden(true, animated: false)
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
  }
  func setupFromConfiguration(_ permission: Permission, configVC: ConfigurationViewController) {
    let vc = NotificationPermissionViewController(navigator: self, permission: permission)
    vc.configVC = configVC
    configVC.present(vc, animated: true, completion: nil)
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setupFromConfiguration")
  }
  func dismiss(_ vc: UIViewController) {
    vc.dismiss(animated: true, completion: nil)
  }
  func toLocationPermission() {
    navigationController.popViewController(animated: true)
  }
}
