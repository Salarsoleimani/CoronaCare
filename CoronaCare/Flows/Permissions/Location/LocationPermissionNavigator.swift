//
//  LocationPermissionNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-25.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Permission
import LocationManager
final class LocationPermissionNavigator: Navigator {
	
	func setup(_ permission: Permission) {
		
		let vc = LocationPermissionViewController(navigator: self, permission: permission)
		navigationController.pushViewController(vc, animated: true)
		navigationController.setNavigationBarHidden(true, animated: false)
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
	}
	func setupFromConfiguration(_ permission: Permission, configVC: ConfigurationViewController) {
		let vc = LocationPermissionViewController(navigator: self, permission: permission)
		vc.configVC = configVC
		configVC.present(vc, animated: true, completion: nil)
	}
	func dismiss(_ vc: UIViewController) {
		vc.dismiss(animated: true, completion: nil)
	}
	func toNotificationPermission(_ permission: Permission) {
		LocationManager.shared.refresh()
		let notifPermissionNavigator = NotificationPermissionNavigator(navigationController: navigationController)
		if permission.status == .authorized {
			notifPermissionNavigator.toTabbar()
			return
		}
		
		notifPermissionNavigator.setup(permission)
	}
}
