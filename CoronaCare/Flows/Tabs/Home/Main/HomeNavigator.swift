//
//  HomeNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-04.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Hero
import AnalyticPlatform

final class HomeNavigator: Navigator {
  func setup() -> UIViewController {
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
    let vc = HomeViewController(navigator: self)
    navigationController.pushViewController(vc, animated: true)
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
    return vc
  }
  func toNewsDetail(_ model: HomeNetworkModel, homeVc: UIViewController) {
    AppAnalytics.shared.log(eventName: "post_detail", parameters: ["postId": model.id])
    let newsDetailNavigator = NewsDetailNavigator(navigationController: navigationController)
    homeVc.hero.isEnabled = true
    newsDetailNavigator.setup(model, homeVC: homeVc)
  }
}
