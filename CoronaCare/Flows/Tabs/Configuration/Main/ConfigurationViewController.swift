//
//  ConfigurationViewController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-04.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Domain
import StepSlider
import CoreDataPlatform
import Permission
import MessageUI
import SwiftRater
import AppEngine
import GoogleMobileAds
import Siren
import AnalyticPlatform
import RxSwift
import RxCocoa
import NotificationPlatform

class ConfigurationViewController: UIViewController {
  @IBOutlet weak var blurBackground: UIVisualEffectView!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var setBedTimeContainerView: UIView!
  @IBOutlet weak var setSaftyLevelContainerView: UIView!
  @IBOutlet weak var languageContainerView: UIView!
  @IBOutlet weak var snoozeMinuteContainerView: UIView!
  @IBOutlet weak var privacyPermissionContainerView: UIView!
  @IBOutlet weak var contactUsContainerView: UIView!
  @IBOutlet weak var donateContainerView: UIView!
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var mainScrollView: UIScrollView!
  @IBOutlet weak var bedtimeLabel: UILabel!
  @IBOutlet weak var wakeupTimeLabel: UILabel!
  @IBOutlet weak var bedtimeTitleLabel: UILabel!
  @IBOutlet weak var wakeupTimeTitleLabel: UILabel!
  @IBOutlet weak var sleepTimeDescriptionLabel: UILabel!
  
  @IBOutlet weak var saftyLevelSlider: StepSlider!
  @IBOutlet weak var saftyLevelDescriptionLabel: UILabel!
  @IBOutlet weak var saftyLevelConfirmationLabel: UILabel!
  
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var languageTitleLabel: UILabel!
  @IBOutlet weak var languageButton: UIButton!
  
  @IBOutlet weak var snoozeLabel: UITextField!
  @IBOutlet weak var snoozeTitleLabel: UILabel!
  
  @IBOutlet weak var privacyDescriptionLabel: UILabel!
  @IBOutlet weak var locationPrivacyButton: UIButtonX!
  @IBOutlet weak var notificationPrivacyButton: UIButtonX!
  
  @IBOutlet weak var rateUsButton: UIButtonX!
  @IBOutlet weak var contactUsButton: UIButtonX!
  @IBOutlet weak var youtubeButton: UIButtonX!
  @IBOutlet weak var instagramButton: UIButtonX!
  
  @IBOutlet weak var donateDescriptionLabel: UILabel!
  @IBOutlet weak var donateButton: UIButtonX!
  @IBOutlet weak var restorePurchaseButton: UIButtonX!
  @IBOutlet weak var removeAdsButton: UIButtonX!
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter
  }()
  let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
  var rewardedAd: GADRewardedAd?
  
  let mc: MFMailComposeViewController = MFMailComposeViewController()
  
  let snoozePickerView = UIPickerView()
  
  private let navigator: ConfigurationNavigator
  var userModel: UserInfoModel?
  
  let languageAlert = UIAlertController(title: "Language_Button_Title".localiz(), message: "Language_Button_Description".localiz(), preferredStyle: .actionSheet)
  
  let donateAlert = UIAlertController(title: "Donate_Button_Title".localiz(), message: "Donate_Description".localiz(), preferredStyle: .actionSheet)
  
  let snoozeMinutes = [2, 3, 5, 8, 10, 15, 20, 30]
  
  init(navigator: ConfigurationNavigator) {
    self.navigator = navigator
    super.init(nibName: "ConfigurationViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK:- viewWillAppear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getUserInfo()
    setupClock()
    setupSaftyLevelSlider()
    setupLanguageAndSnooze()
    setupPrivacyUIButtons()
  }
  
  private func setupClock() {
    if let userInfo = userModel, let sleepTime = userInfo.sleepTime, let wakeupTime = userInfo.wakeupTime {
      bedtimeLabel.text = sleepTime
      wakeupTimeLabel.text = wakeupTime
    }
  }
  
  private func setupSaftyLevelSlider() {
    if let userInfo = userModel {
      saftyLevelSlider.index = UInt(userInfo.saftyLevel.rawValue)
      if let saftyLevel = SafetyLevel(rawValue: Int16(saftyLevelSlider.index)) {
        setLabelOfSaftyLevel(saftyLevel)

        switch saftyLevel {
        case .basic:
          saftyLevelSlider.tintColor = SColor.error.value
          
        case .low:
          saftyLevelSlider.tintColor = SColor.error.value
          
        case .medium:
          saftyLevelSlider.tintColor = SColor.orange.value
          
        case .high:
          saftyLevelSlider.tintColor = SColor.yellow.value
          
        case .veryHigh:
          saftyLevelSlider.tintColor = SColor.green.value
          
        }
      }
    }
  }
  
  private func setupPrivacyUIButtons() {
    let locPermission = Permission.locationAlways
    let notifPermission = Permission.notifications
    if locPermission.status == .authorized {
      locationPrivacyButton.backgroundColor = SColor.green.value
      locationPrivacyButton.setTitle("Location_Permission_Authorized_Title".localiz(), for: .normal)
    } else {
      locationPrivacyButton.backgroundColor = SColor.error.value
      locationPrivacyButton.setTitle("Location_Permission_Denied_Title".localiz(), for: .normal)
    }
    
    if notifPermission.status == .authorized {
      notificationPrivacyButton.backgroundColor = SColor.green.value
      notificationPrivacyButton.setTitle("Notification_Permission_Authorized_Title".localiz(), for: .normal)
    } else {
      notificationPrivacyButton.backgroundColor = SColor.error.value
      notificationPrivacyButton.setTitle("Notification_Permission_Denied_Title".localiz(), for: .normal)
    }
  }
  
  private func setupLanguageAndSnooze() {
    snoozeLabel.text = String(StaticConstants.snoozeMinutes) + "Snooze_Minutes".localiz()
    if let userModel = userModel {
      languageLabel.text = userModel.languageId.asStringName()
    }
  }
  
  private func getUserInfo() {
    DatabaseManager.shared.getUserInfo(response: { [weak self] (userInfo) in
      self?.userModel = userInfo
    }) { [weak self] (err) in
      self?.bedtimeLabel.text = "00:00"
      self?.wakeupTimeLabel.text = "08:00"
      self?.saftyLevelSlider.index = UInt(SafetyLevel.defaultLevel.rawValue)
      self?.languageLabel.text = LanguageId.defaultValue.asStringName()
      self?.languageButton.tag = Int(LanguageId.defaultValue.rawValue)
    }
  }
  
  // MARK:- Actions
  @IBAction func updateSaftyLevelSliderWhenTouchEnded(_ sender: AnyObject) {
    if let saftyLevel = SafetyLevel(rawValue: Int16(saftyLevelSlider.index)) {
      AppEngine.shared.changeConfig(toSafetyLevel: saftyLevel)
      setLabelOfSaftyLevel(saftyLevel)
    }
  }
  private func setLabelOfSaftyLevel(_ saftyLevel: SafetyLevel) {
    let events = SafetyLevel.makeEvents(saftyLevel)()
    var saftyLevelConfirmationLabelText = events.reduce("") { (text, ittrItem) -> String in
      let key = ittrItem.asEventProtocol().getName() + "_ConfigTitle"
      return text + key.localiz() + "\n"
    }
    
    saftyLevelConfirmationLabelText.removeLast()
    saftyLevelConfirmationLabelText.removeLast()
    saftyLevelConfirmationLabel.text = saftyLevelConfirmationLabelText
  }
  
  @IBAction func updateSaftyLevelSlider(_ sender: AnyObject) {
    switch saftyLevelSlider.index {
    case 0:
      saftyLevelSlider.tintColor = SColor.error.value
    case 1:
      saftyLevelSlider.tintColor = SColor.error.value
    case 2:
      saftyLevelSlider.tintColor = SColor.orange.value
    case 3:
      saftyLevelSlider.tintColor = SColor.yellow.value
    case 4:
      saftyLevelSlider.tintColor = SColor.green.value
    default:
      saftyLevelSlider.tintColor = SColor.green.value
    }
  }
  @IBAction func sleepTimeControllerButtonPressed(_ sender: UIButton) {
    navigator.toSleepTime(self, userInfo: userModel)
  }
  @IBAction func languageButtonPressed(_ sender: UIButton) {
    present(languageAlert, animated: true, completion: nil)
  }
  private func didSelectLanguage(_ langId: LanguageId) {
    // [TODO] - Force change imediately
    AnalyticLogProvider.logLanguageType(hostName: NSStringFromClass(type(of: self)), functionName: "didSelectLanguage", languageType: langId)
    switch langId {
    case .EN:
      setLanguage(.en)
      Siren.shared.presentationManager = PresentationManager(forceLanguageLocalization: .english)
    case .IR:
      setLanguage(.fa)
      Siren.shared.presentationManager = PresentationManager(forceLanguageLocalization: .persianIran)
    case .CH:
      setLanguage(.zhHans)
      Siren.shared.presentationManager = PresentationManager(forceLanguageLocalization: .chineseSimplified)
    }
    languageButton.tag = Int(langId.rawValue)
    languageLabel.text = langId.asStringName()
  }
  private func setLanguage(_ lang: Languages) {
    LanguageManager.shared.setLanguage(language: lang)
    setupUI()
  }
  @IBAction func snoozeButtonPressed(_ sender: UIButton) {
    snoozeLabel.becomeFirstResponder()
  }
  @IBAction func youtubeButtonPressed(_ sender: UIButton) {
    AnalyticLogProvider.logSocialMedia(hostName: NSStringFromClass(type(of: self)), functionName: "youtubeButtonPressed", site: "youtube")
    Utility.openURL(url: Constants.Links.youtube.rawValue)
  }
  @IBAction func instagramButtonPressed(_ sender: UIButton) {
    AnalyticLogProvider.logSocialMedia(hostName: NSStringFromClass(type(of: self)), functionName: "instagramButtonPressed", site: "instagram")
    Utility.openURL(url: Constants.Links.instagram.rawValue)
  }
  @IBAction func contactUsButtonPressed(_ sender: UIButton) {
    AnalyticLogProvider.logSocialMedia(hostName: NSStringFromClass(type(of: self)), functionName: "contactUsButtonPressed", site: "email")
    composeEmail(email: Constants.Links.mail.rawValue, subject: Constants.Links.mailSubject.rawValue)
  }
  @IBAction func rateUsButtonPressed(_ sender: UIButton) {
    AnalyticLogProvider.logSocialMedia(hostName: NSStringFromClass(type(of: self)), functionName: "rateUsButtonPressed", site: "rateUs")
    SwiftRater.rateApp()
  }
  @IBAction func locationPrivacyButtonPressed(_ sender: UIButton) {
    let locPermission = Permission.locationAlways
    if locPermission.status != .authorized {
      navigator.toLocationPermission(locPermission, configVC: self)
    }
  }
  @IBAction func notificationPrivacyButtonPressed(_ sender: UIButton) {
    let notifPermission = Permission.notifications
    if notifPermission.status != .authorized {
      navigator.toNotificationPermission(notifPermission, configVC: self)
    }
  }
  @IBAction func donateButtonPressed(_ sender: UIButton) {
    present(donateAlert, animated: true, completion: nil)
  }
  @IBAction func restorePurchaseButtonPressed(_ sender: UIButton) {
    IAPService.shared.restorePurchases(self)
  }
  @IBAction func removeAdsButtonPressed(_ sender: UIButton) {
    IAPService.shared.purchase(product: .removeAds, configurationPageDelegate: self)
  }
  // MARK:- viewWillDisappear
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    updateUserInfo()
  }
  func updateUserInfo() {
    dateFormatter.dateFormat = "HH:mm"
    
    let bedtime = TimeInterval(24 * 60 * 60)
    var bedtimeDate = dateFormatter.string(from: Date(timeIntervalSince1970: bedtime))
    let wake = TimeInterval(8 * 60 * 60)
    var wakeDate = dateFormatter.string(from: Date(timeIntervalSince1970: wake))
    if let userInfo = userModel, let sleepTime = userInfo.sleepTime, let wakeupTime = userInfo.wakeupTime {
      bedtimeDate = sleepTime
      wakeDate = wakeupTime
    }
    
    let langId = LanguageId(rawValue: Int16(languageButton.tag)) ?? LanguageId.defaultValue
    
    let saftyLevel = saftyLevelSlider.index
    
    let userInfo = UserInfoModel(sleeptime: bedtimeDate, wakeupTime: wakeDate, languageId: langId.rawValue , saftyLevel: Int16(saftyLevel))
    
    DatabaseManager.shared.update(UserInfo: userInfo, completion: { (updated) in
      if updated {
        AppEngine.shared.notificationConfigChanged(config: userInfo)
      }
      print("user info updated: \(updated)")
    }) { (err) in
      print("error updating new user info in configuration: \(err)")
    }
    dateFormatter.dateFormat = "HH:mm a"
    
  }
  // MARK:- ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationManager.shared.upNextNotifications(forEvent: HandsCareEvent()) { (notifs) in
      print(notifs.map{$0.fireDate.timeIntervalSinceNow / 60})
    }
    setupAnalyticsLog()
    if !StaticConstants.isAdsRemoved {
      setupGoogleAd()
    } else {
      removeAdsButtons()
    }
    setupUI()
    setupLanguageAlert()
    setupDonateAlert()
    setupSnoozePickerView()
    IAPService.shared.getProducts()
  }
  private func setupAnalyticsLog() {
    let logger = AnalyticLogProvider()
    let observable = Observable.combineLatest(Observable.just(logger), mainScrollView.rx.contentOffset.asObservable())
    observable.map { (arg) -> Void in
      let (logger, point) = arg
      return logger.logScrollingVisit(hostName: "StatisticsViewController", scrollName: "tableView", offset: Float(point.y), contentSize: Float(self.mainScrollView.contentSize.height))
    }.subscribe().disposed(by: disposeBag)
  }
  private func removeAdsButtons() {
    removeAdsButton.isHidden = true
    restorePurchaseButton.isHidden = true
  }
  private func setupGoogleAd() {
    bannerView.adUnitID = adBannerConfigurationBottom // [TODO] -force change to adBannerConfigurationBottom
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    //bannerView.delegate = self
    addBannerViewToView(bannerView)
    if StaticConstants.appOpenedCount > 20 {
      rewardedAd = createAndLoadRewardedAd()
    }
  }
  private func createAndLoadRewardedAd() -> GADRewardedAd? {
    rewardedAd = GADRewardedAd(adUnitID: adRewardedConfiguration) // [TODO] -force change to adRewardedConfiguration
    rewardedAd?.load(GADRequest()) { error in
      if let error = error {
        print("Loading ad failed: \(error)")
      } else {
        print("Loading ad Succeeded")
      }
    }
    return rewardedAd
  }
  private func setupUI() {
    titleLabel.text = "Configuration_Navigation_Title".localiz()
    saftyLevelSlider.enableHapticFeedback = true
    
    view.backgroundColor = SColor.background.value
    [bedtimeLabel, wakeupTimeLabel, sleepTimeDescriptionLabel, saftyLevelDescriptionLabel, saftyLevelConfirmationLabel, languageLabel, privacyDescriptionLabel, donateDescriptionLabel].forEach { (label) in
      label?.textColor = SColor.text.value
    }
    snoozeLabel.textColor = SColor.text.value
    [languageTitleLabel, snoozeTitleLabel].forEach { (label) in
      label?.textColor = SColor.orange.value
    }
    [restorePurchaseButton, removeAdsButton].forEach { (button) in
      button?.setTitleColor(SColor.orange.value, for: .normal)
    }
    [setBedTimeContainerView, setSaftyLevelContainerView, languageContainerView, snoozeMinuteContainerView, snoozeMinuteContainerView, contactUsContainerView, donateContainerView, privacyPermissionContainerView].forEach { (view) in
      view?.layer.cornerRadius = 15
      view?.backgroundColor = SColor.secondBackground.value
    }
    blurBackground.layer.cornerRadius = blurBackground.bounds.size.height / 2
    
    languageTitleLabel.text = "Language_Button_Title".localiz()
    
    bedtimeTitleLabel.text = "Default_BedTime_Title_Label".localiz()
    wakeupTimeTitleLabel.text = "Default_WakeUpTime_Title_Label".localiz()
    sleepTimeDescriptionLabel.text = "Default_SleepTime_Description".localiz()
    
    saftyLevelDescriptionLabel.text = "Default_SaftyLevel_Description".localiz()
    
    saftyLevelSlider.labels = ["Basic_SaftyLevel_Title".localiz(), "Low_SaftyLevel_Title".localiz(), "Medium_SaftyLevel_Title".localiz(), "High_SaftyLevel_Title".localiz(), "VeryHigh_SaftyLevel_Title".localiz()]
    saftyLevelSlider.labelColor = SColor.lightGray.value
    saftyLevelSlider.labelFont = UIFont.systemFont(ofSize: 10, weight: .regular)
    
    snoozeLabel.tintColor = .clear
    
    snoozeTitleLabel.text = "Snooze_Minutes_Title".localiz()
    
    [rateUsButton, contactUsButton, instagramButton, youtubeButton].forEach { (button) in
      button?.backgroundColor = SColor.orange.value
    }
    rateUsButton.setTitle("Rate_Us_Title".localiz(), for: .normal)
    contactUsButton.setTitle("Contact_Us_Title".localiz(), for: .normal)
    instagramButton.setTitle("Instagram_Title".localiz(), for: .normal)
    youtubeButton.setTitle("Youtube_Title".localiz(), for: .normal)
    
    locationPrivacyButton.setTitle("Permission_Location_Title".localiz(), for: .normal)
    notificationPrivacyButton.setTitle("Notification_Location_Title".localiz(), for: .normal)
    privacyDescriptionLabel.text = "Permission_Description".localiz()
    
    donateButton.setTitle("Donate_Button_Title".localiz(), for: .normal)
    restorePurchaseButton.setTitle("Restore_Purchase_Button_Title".localiz(), for: .normal)
    removeAdsButton.setTitle("Remove_Ads_Button_Title".localiz(), for: .normal)
    donateDescriptionLabel.text = "Donate_Description".localiz()
  }
  private func setupLanguageAlert() {
    let ENaction = UIAlertAction(title: LanguageId.EN.asStringName(), style: .default) { [weak self] _ in
      self?.didSelectLanguage(LanguageId.EN)
    }
    let FAaction = UIAlertAction(title: LanguageId.IR.asStringName(), style: .default) { [weak self] _ in
      self?.didSelectLanguage(LanguageId.IR)
    }
    let CHaction = UIAlertAction(title: LanguageId.CH.asStringName(), style: .default) { [weak self] _ in
      self?.didSelectLanguage(LanguageId.CH)
    }
    let closeAction = UIAlertAction(title: "Close", style: .cancel) { [weak self] _ in
      self?.languageAlert.dismiss(animated: true, completion: nil)
    }
    [ENaction, FAaction, CHaction, closeAction].forEach { (action) in
      languageAlert.addAction(action)
    }
  }
  private func setupDonateAlert() {
    let oneDolarAction = UIAlertAction(title: "0.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 1)
    }
    let threeDollarAction = UIAlertAction(title: "2.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 3)
    }
    let fiveDollarAction = UIAlertAction(title: "4.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 5)
    }
    let tenDollarAction = UIAlertAction(title: "9.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 10)
    }
    let twentyDollarAction = UIAlertAction(title: "19.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 20)
    }
    let fiftyDollarAction = UIAlertAction(title: "49.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 50)
    }
    let hundredDollarAction = UIAlertAction(title: "99.99 USD", style: .default) { [weak self] _ in
      self?.didSelectDonate(false, dollar: 100)
    }
    let videoAction = UIAlertAction(title: "Watch ad video", style: .default) { [weak self] _ in
      self?.didSelectDonate(true, dollar: 0)
    }
    let closeAction = UIAlertAction(title: "Close", style: .cancel) { [weak self] _ in
      self?.donateAlert.dismiss(animated: true, completion: nil)
    }
    [oneDolarAction, threeDollarAction, fiveDollarAction, tenDollarAction, twentyDollarAction, fiftyDollarAction, hundredDollarAction, videoAction, closeAction].forEach { (action) in
      donateAlert.addAction(action)
    }
  }
  private func didSelectDonate(_ isVideo: Bool, dollar: Int) {
    if isVideo {
      if rewardedAd?.isReady == true {
        rewardedAd?.present(fromRootViewController: self, delegate: self)
      }
      return
    }
    switch dollar {
    case 1:
      IAPService.shared.purchase(product: .oneDollar)
    case 3:
      IAPService.shared.purchase(product: .threeDollar)
    case 5:
      IAPService.shared.purchase(product: .fiveDollar)
    case 10:
      IAPService.shared.purchase(product: .tenDollar)
    case 20:
      IAPService.shared.purchase(product: .twentyDollar)
    case 50:
      IAPService.shared.purchase(product: .finftyDollar)
    case 100:
      IAPService.shared.purchase(product: .hundredDollar)
    default:
      print("dolaro eshtebah zad")
    }
  }
  private func setupSnoozePickerView() {
    snoozePickerView.dataSource = self
    snoozePickerView.delegate = self
    snoozeLabel.inputView = snoozePickerView
  }
  
  // MARK:- setup compose mail
  private func composeEmail(email: String, subject: String) {
    guard MFMailComposeViewController.canSendMail() else {
      showFeatureNotSupportedAlert()
      return
    }
    let mail = MFMailComposeViewController()
    mail.mailComposeDelegate = self
    mail.setToRecipients([email])
    mail.setMessageBody("", isHTML: true)
    mail.setSubject(subject)
    present(mail, animated: true)
  }
  private func showFeatureNotSupportedAlert(message: String = "Your device does not support this feature") {
    let alert = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Discard", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}

extension ConfigurationViewController: ConfigurationViewControllerDelegate {
  func didAdsRemoved(completion: @escaping () -> ()) {
    DispatchQueue.main.async { [bannerView, removeAdsButtons] in
      removeAdsButtons()
      bannerView.isHidden = true
    }
    
  }
  
  func didSaveSleepTime(userModel: UserInfoModel?) {
    self.userModel = userModel
    if let sleepDate = userModel?.sleepTime, let wakeDate = userModel?.wakeupTime {
      bedtimeLabel.text = sleepDate
      wakeupTimeLabel.text = wakeDate
    }
  }
}
extension ConfigurationViewController: GADRewardedAdDelegate {
  func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
    AppAnalytics.shared.countUpRewardAd()
  }
  func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
    self.rewardedAd = createAndLoadRewardedAd()
  }
}
