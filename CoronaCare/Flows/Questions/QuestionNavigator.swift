//
//  QuestionNavigator.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/10/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Domain
import SwiftUI
import GoogleMobileAds
import AnalyticPlatform

final class QuestionNavigator: Navigator {
	var rewardedAd: GADRewardedAd?
	
	let dataBaseServices: DataBaseManagerInterface
	init(navigationController: UINavigationController, dataBase: DataBaseManagerInterface) {
		self.dataBaseServices = dataBase
		super.init(navigationController: navigationController)
	}
	private func setupGoogleAd() {
    if StaticConstants.appOpenedCount > 20 {
      rewardedAd = createAndLoadRewardedAd()
    }
	}
	private func createAndLoadRewardedAd() -> GADRewardedAd? {
		rewardedAd = GADRewardedAd(adUnitID: adRewardedQuestion) // [TODO] -force change to adRewardedQuestion
		rewardedAd?.load(GADRequest()) { error in
			if let error = error {
				print("Loading ad failed: \(error)")
			} else {
				print("Loading ad Succeeded")
			}
		}
		return rewardedAd
	}
	func setup(errorHandler: (Error) -> Void) {
		
		setupGoogleAd()
		dataBaseServices.getNotificationLogs(forAnswerType: .noAnswer, beforeDate: Date(), response: { [load](items) in
			
			let questions = items.compactMap { (log) -> QuestionModel in
				return log.eventId.asEventType().asEventProtocol().makeQuestion(withNotificationId: log.id)
			}
			
			load(questions)
		}) { [errorHandler] (error) in
			errorHandler(error)
		}
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
	}
	private func load(withQuestionModels models: [QuestionModel]) {
		let viewModels = models.compactMap { (item) -> QuestionViewModel in
			return QuestionViewModel(model: item)
		}
		let questionViewModel = QuestionPageViewModel(models: viewModels, dataBase: dataBaseServices, navigator: self)
		let viewController = QuestionPage(viewModel: questionViewModel)
		
		if let parentVC = navigationController.viewControllers.last?.presentedViewController ?? navigationController.viewControllers.last, !(parentVC is UITabBarController) {
			
			parentVC.present(viewController, animated: true, completion: nil)
			return
		}
		navigationController.pushViewController(viewController, animated: true)
	}
	func showRewardedAd() -> UIViewController? {
		if let parentVC = navigationController.viewControllers.last?.presentedViewController ?? navigationController.viewControllers.last, !(parentVC is UITabBarController) {
			if parentVC is QuestionPage {
				parentVC.dismiss(animated: true) {
					self.toHomeWithAds()
				}
			}
		}
		return navigationController.popViewController(animated: true)
	}
	
	func toHomeWithAds() {
	
		AnalyticLogProvider.logAdsInNavigator(hostName: "QuestionNavigator", functionName: "toHomeWithAds", status: true)
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		
		if rewardedAd?.isReady == true {
			toTabbar { [rewardedAd, unowned self](presentingVC) in
				rewardedAd?.present(fromRootViewController: presentingVC, delegate: self)
			}
			return
		}
		AnalyticLogProvider.logAdsInNavigator(hostName: "QuestionNavigator", functionName: "toHomeWithAds", status: false)
		toTabbar()
		
	}
	func questionsCompleted() {
		let vc = showRewardedAd()
		vc?.dismiss(animated: true, completion: { [toTabbar] in
			toTabbar(nil)
		})
		navigationController.popViewController(animated: true)
	}
	
}

extension QuestionNavigator: GADRewardedAdDelegate {
	func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
		AppAnalytics.shared.countUpRewardAdInQuestion()
	}
	
	func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
		self.rewardedAd = createAndLoadRewardedAd()
	}
}
