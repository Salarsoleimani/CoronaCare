//
//  LocationPermissionViewController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-29.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Lottie
import Permission

class LocationPermissionViewController: UIViewController {
  @IBOutlet weak var locationLottieView: AnimationView!
  @IBOutlet weak var locationPermissionButton: UIButton!
  @IBOutlet weak var locPermissionDescription: UILabel!

  @IBOutlet weak var skipButton: UIButton!
  
  private let navigator: LocationPermissionNavigator
  private let permission: Permission
  var configVC: ConfigurationViewController?
  
  init(navigator: LocationPermissionNavigator, permission: Permission) {
    self.permission = permission
    self.navigator = navigator
    super.init(nibName: "LocationPermissionViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLottieAnimation()
    requestPermision()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateLocationPermissionButtonUI()
  }
  private func setupLottieAnimation() {
    let notificationAnimation = Animation.named("LocationAccess")
    locationLottieView.animation = notificationAnimation
    locationLottieView.contentMode = .scaleAspectFit
    locationLottieView.loopMode = .loop
    locationLottieView.play()
  }
  private func requestPermision() {
    permission.request { [weak self] _ in
      self?.updateLocationPermissionButtonUI()
    }
  }
  
  @IBAction func locationButtonPressed(_ sender: Any) {
    if permission.status == .authorized {
      if let configVC = configVC {
        navigator.dismiss(configVC)
      } else {
        navigator.toNotificationPermission(Permission.notifications)
      }
    }
    requestPermision()
  }
  
  private func updateLocationPermissionButtonUI() {
    switch permission.status {
    case .authorized:
      changeLocationPermissionButtonUI(SColor.lightGreen)
      locationPermissionButton.setTitle("Location_Permission_Authorized_Title".localiz(), for: .normal)
      if let configVC = configVC {
        navigator.dismiss(configVC)
      } else {
        navigator.toNotificationPermission(Permission.notifications)
      }
    case .denied:
      changeLocationPermissionButtonUI(SColor.error)
      locationPermissionButton.setTitle("Location_Permission_Denied_Title".localiz(), for: .normal)
    case .disabled:
      changeLocationPermissionButtonUI(SColor.error)
      locationPermissionButton.setTitle("Location_Permission_Denied_Title".localiz(), for: .normal)
    case .notDetermined:
      changeLocationPermissionButtonUI(SColor.lightBlue)
      locationPermissionButton.setTitle("Location_Permission_Denied_Title".localiz(), for: .normal)
    }
  }
  private func changeLocationPermissionButtonUI(_ color: SColor) {
    DispatchQueue.main.async {
      self.locationPermissionButton.backgroundColor = color.value
    }
  }
  @IBAction func skipButtonPressed(_ sender: Any) {
    if Permission.notifications.status != .authorized {
      navigator.toNotificationPermission(Permission.notifications)
    } else {
      navigator.toTabbar()
    }
    
    if let configVC = configVC {
      navigator.dismiss(configVC)
    }
  }
  private func setupUI() {
    view.backgroundColor = SColor.yelloBackground.value
    skipButton.setTitleColor(SColor.lightBlue.value, for: .normal)
    skipButton.setTitle("Skip_Title".localiz(), for: .normal)
    locationLottieView.layer.cornerRadius = StaticConstants.mainScreenWidth * 0.92 / 1.65 / 2
    
    locPermissionDescription.text = "Location_Permission_description".localiz()
  }
}
