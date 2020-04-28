//
//  Navigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-25.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import UIKit
import CBFlashyTabBarController
import CoreDataPlatform

class Navigator: NSObject {
    internal let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
	func toTabbar(withDefaultPresentedController handler: ((UIViewController) -> Void)? = nil) {
		Application.shared.run()
		//Initiate your viewControllers
		let statisticNavigationController = UINavigationController()
		statisticNavigationController.navigationBar.prefersLargeTitles = true
		statisticNavigationController.setNavigationBarHidden(false, animated: false)
		let statisticNavigator = StatisticsNavigator(navigationController: statisticNavigationController)
		let statisticVC = statisticNavigator.setup(dataBase: DatabaseManager.shared)
    statisticVC.title = "Statistic_Navigation_Title".localiz()
		
		let newsNavigationController = UINavigationController()
		newsNavigationController.navigationBar.prefersLargeTitles = true
		newsNavigationController.setNavigationBarHidden(false, animated: false)
		let newsNavigator = HomeNavigator(navigationController: newsNavigationController)
		let newsVC = newsNavigator.setup()
    newsVC.title = "Home_Navigation_Title".localiz()
		
		let configurationNavigationController = UINavigationController()
		configurationNavigationController.navigationBar.prefersLargeTitles = true
		configurationNavigationController.setNavigationBarHidden(false, animated: false)
		let configurationNavigator = ConfigurationNavigator(navigationController: configurationNavigationController)
		let configurationVC = configurationNavigator.setup()
    configurationVC.title = "Configuration_Navigation_Title".localiz()
		
		//get instance of BEKCurveTabbarController
		let tabBarViewController = CBFlashyTabBarController()
		

		newsVC.tabBarItem = UITabBarItem(title: "Posts", image: UIImage(named: "Tab_Posts"), tag: 0)
		statisticVC.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "Tab_Stat"), tag: 0)
		configurationVC.tabBarItem = UITabBarItem(title: "Configs", image: UIImage(named: "Tab_Config"), tag: 0)
		//    tabBarViewController.setupViewModel(viewModel: TabBarViewModel())
		//set viewControllers to the tabbar
		tabBarViewController.setViewControllers([newsVC, statisticVC, configurationVC], animated: true)
		
		navigationController.setViewControllers([tabBarViewController], animated: true)
		if let safe = handler  {
			safe(newsVC)
		}
	}
  func logError(error: Error, navigatorName name: String, message: String = "Empty"){
    print("-------------\nerror inside \(name) Navigator -> \(error) \nmessage: \(message) \n-------------\n")
    DispatchQueue.main.async { [navigationController, error] in
      let errorVC = PopUpCoverViewController(nibName: "PopUpCoverViewController", bundle: nil)
      errorVC.viewModel = error.asPopUpCoverViewModel()
      errorVC.modalPresentationStyle = .overCurrentContext
      errorVC.loadView()
      errorVC.isHeroEnabled = true
      errorVC.mainView.hero.modifiers = [.fade, .translate(y: 100)]
      if let upperVC = navigationController.viewControllers.last {
        if let presented = upperVC.presentedViewController{
          presented.present(errorVC, animated: true, completion: nil)
          return
        }
        upperVC.present(errorVC, animated: true, completion: nil)
      }
    }
  }
}
