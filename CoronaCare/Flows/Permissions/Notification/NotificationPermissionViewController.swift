//
//  NotificationPermissionViewController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-29.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Lottie
import Permission

class NotificationPermissionViewController: UIViewController {
  @IBOutlet weak var notificationLottieView: AnimationView!
  @IBOutlet weak var notificationPermissionButton: UIButton!
  @IBOutlet weak var notifPermissionDescription: UILabel!

  @IBOutlet weak var notificaitonBasisDescriptionLabel: UILabel!
  
  @IBOutlet weak var skipButton: UIButton!

  private let navigator: NotificationPermissionNavigator
  private let permission: Permission
  
  var configVC: ConfigurationViewController?
  
  init(navigator: NotificationPermissionNavigator, permission: Permission) {
    self.permission = permission
    self.navigator = navigator
    super.init(nibName: "NotificationPermissionViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = SColor.yelloBackground.value
    notificationLottieView.layer.cornerRadius = StaticConstants.mainScreenWidth * 0.92 / 1.65 / 2
    setupLottieAnimation()
    requestPermission()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateNotificationPermissionButtonUI()
  }
  private func setupLottieAnimation() {
    let notificationAnimation = Animation.named("NotificationAccess")
    notificationLottieView.animation = notificationAnimation
    notificationLottieView.contentMode = .scaleAspectFit
    notificationLottieView.loopMode = .loop
    notificationLottieView.play()
  }
  private func requestPermission() {
    permission.request { [weak self] _ in
      self?.updateNotificationPermissionButtonUI()
    }
  }
  
  @IBAction func notificationButtonPressed(_ sender: Any) {
    if permission.status == .authorized {
      if let configVC = configVC {
        navigator.dismiss(configVC)
      } else {
        navigator.toTabbar()
      }
    }
    requestPermission()
  }
  private func updateNotificationPermissionButtonUI() {
    switch permission.status {
    case .authorized:
      changeNotificationPermissionButtonUI(SColor.lightGreen)
      notificaitonBasisDescriptionLabel.isHidden = true
      notificationPermissionButton.setTitle("Notification_Permission_Authorized_Title".localiz(), for: .normal)
      if let configVC = configVC {
        navigator.dismiss(configVC)
      } else {
        navigator.toTabbar()
      }
    case .denied:
      changeNotificationPermissionButtonUI(SColor.error)
      notificaitonBasisDescriptionLabel.isHidden = false
      notificationPermissionButton.setTitle("Notification_Permission_Denied_Title".localiz(), for: .normal)
    case .disabled:
      changeNotificationPermissionButtonUI(SColor.error)
      notificaitonBasisDescriptionLabel.isHidden = false
      notificationPermissionButton.setTitle("Notification_Permission_Denied_Title".localiz(), for: .normal)
    case .notDetermined:
      changeNotificationPermissionButtonUI(SColor.lightBlue)
      notificaitonBasisDescriptionLabel.isHidden = false
      notificationPermissionButton.setTitle("Notification_Permission_Denied_Title".localiz(), for: .normal)
    }
  }
  @IBAction func skipButtonPressed(_ sender: Any) {
    if let configVC = configVC {
      navigator.dismiss(configVC)
    } else {
      navigator.toTabbar()
    }
  }
  private func changeNotificationPermissionButtonUI(_ color: SColor) {
    DispatchQueue.main.async {
      self.notificationPermissionButton.backgroundColor = color.value
    }
  }
  private func setupUI() {
    view.backgroundColor = SColor.yelloBackground.value
    skipButton.setTitleColor(SColor.lightBlue.value, for: .normal)
    skipButton.setTitle("Skip_Title".localiz(), for: .normal)
    notificationLottieView.layer.cornerRadius = StaticConstants.mainScreenWidth * 0.92 / 1.65 / 2
    
    notificaitonBasisDescriptionLabel.text = "Notification_Permission_Basis_description".localiz()
    notifPermissionDescription.text = "Notification_Permission_description".localiz()
  }
}
