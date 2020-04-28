//
//  UIViewControllerExtension.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension UIViewController {
  func addBannerViewToView(_ bannerView: GADBannerView) {
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    if #available(iOS 11.0, *) {
      // In iOS 11, we need to constrain the view to the safe area.
      positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
    }
    else {
      // In lower iOS versions, safe area is not available so we use
      // bottom layout guide and view edges.
      positionBannerViewFullWidthAtBottomOfView(bannerView)
    }
  }
  @available (iOS 11, *)
  func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
    // Position the banner. Stick it to the bottom of the Safe Area.
    // Make it constrained to the edges of the safe area.
    let guide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
      guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
      guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
    ])
  }
  func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
    view.addConstraint(NSLayoutConstraint(item: bannerView,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .leading,
                                          multiplier: 1,
                                          constant: 0))
    view.addConstraint(NSLayoutConstraint(item: bannerView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: 0))
    view.addConstraint(NSLayoutConstraint(item: bannerView,
                                          attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: view.safeAreaLayoutGuide.bottomAnchor,
                                          attribute: .top,
                                          multiplier: 1,
                                          constant: 0))
  }
}
