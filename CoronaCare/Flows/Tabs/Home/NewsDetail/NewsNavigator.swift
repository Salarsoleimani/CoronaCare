//
//  NewsNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Hero

final class NewsDetailNavigator: Navigator {
  func setup(_ model: HomeNetworkModel, homeVC: UIViewController) {
    let vc = NewsDetailController(navigator: self, model: model)
    vc.hero.isEnabled = true
    vc.loadView()
    vc.view.hero.id = String(model.id) + "background"
    vc.newsTitleLabel.hero.id = String(model.id) + "title"
    vc.newsImageView.hero.id = String(model.id)
    vc.headlineLabel.hero.id = String(model.id) + "headline"
    vc.newsDescriptionLabel.hero.modifiers = [.translate(y:-100)]
    
    vc.view.layoutIfNeeded()
    vc.view.layoutSubviews()
    vc.setupUI()
    vc.modalPresentationStyle = .overCurrentContext
    homeVC.present(vc, animated: true, completion: nil)
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
  }
  
  func close(vc: UIViewController) {
    vc.hero.dismissViewController()
    navigationController.popViewController(animated: true)
  }
}
