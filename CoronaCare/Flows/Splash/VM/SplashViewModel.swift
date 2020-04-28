//
//  SplashViewModel.swift
//
//  Created by Behrad Kazemi on 12/29/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import UIKit
import Permission

final class SplashViewModel {
  
  private let navigator: SplashNavigator
  let scalePop: CGFloat = 0.05
  init( navigator: SplashNavigator) {
    self.navigator = navigator
  }
  func goToHomePage(handler: (()->())?) {
    if !StaticConstants.isOnboardingWatched {
      navigator.toOnboarding()
      return
    }
    let locPermission = Permission.locationAlways
    if locPermission.status != .authorized {
      navigator.toLocationPermission(locPermission)
      return
    }
    let notifPermission = Permission.notifications
    if notifPermission.status != .authorized {
      navigator.toNotificationPermission(notifPermission)
      return
    }
    navigator.toQuestions()
  }
  func popUpdateManagerIfNeeded(handler: @escaping (_ updateNotice: UpdateNotice, _ currentVersion: String, _ updateUrl: String)->()) {
    guard let url = URL(string: "http://www.mocky.io/v2/5e71d5323300008c0044c40c") else {return}
    guard let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {return}
    let buildNum = Int(buildNumber) ?? 1
    NetworkManager.shared.fetchGenericDataWithURL(url: url) { [navigator] (resp: VersionNetworkModel?, errors) in
      if let versionResponse = resp {
        if versionResponse.min > buildNum {
          handler(UpdateNotice.forceUpdate, versionResponse.currentVersion, versionResponse.url)
        } else if buildNum >= versionResponse.min, buildNum <= versionResponse.max {
          handler(UpdateNotice.needUpdate, versionResponse.currentVersion, versionResponse.url)
        } else {
          navigator.toQuestions()
        }
      } else {
        navigator.toQuestions()
      }
    }
  }
}
public enum UpdateNotice: String {
  case forceUpdate
  case needUpdate
  case updated
}

