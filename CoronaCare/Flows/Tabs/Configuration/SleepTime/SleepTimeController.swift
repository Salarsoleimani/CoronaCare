//
//  SleepTimeController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import HGCircularSlider
import Domain

protocol ConfigurationViewControllerDelegate {
  func didSaveSleepTime(userModel: UserInfoModel?)
  func didAdsRemoved(completion: @escaping ()->())
}
class SleepTimeController: UIViewController {
  
  @IBOutlet weak var setTimeDescriptionLabel: UILabel!
  @IBOutlet weak var bedTimeTitleLabel: UILabel!
  @IBOutlet weak var bedTimeLabel: UILabel!
  @IBOutlet weak var wakeUpTimeTitleLabel: UILabel!
  @IBOutlet weak var wakeupTimeLabel: UILabel!
  @IBOutlet weak var sleepTimeSlider: RangeCircularSlider!
  
  @IBOutlet weak var sleepDurationLabel: UILabel!
  @IBOutlet weak var hourImage: UIImageView!
  
  @IBOutlet weak var saveButton: UIButtonX!
  
  var delegate: ConfigurationViewControllerDelegate?
  var userModel: UserInfoModel?
  
  let navigator: SleepTimeNavigator
  
  lazy var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter
  }()
  
  init(navigator: SleepTimeNavigator) {
    self.navigator = navigator
    super.init(nibName: "SleepTimeController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupClock()
  }
  private func setupClock() {
    if let userInfo = userModel, let sleepTime = userInfo.sleepTime, let wakeupTime = userInfo.wakeupTime {
      let calendar = Calendar.current
      
      let sleepTimeDate = Date().getTodaysDateFor(timeString: sleepTime)
      let sleepTimeHour = calendar.component(.hour, from: sleepTimeDate)
      let sleepTimeMinutes = calendar.component(.minute, from: sleepTimeDate)
      sleepTimeSlider.startPointValue = CGFloat((sleepTimeHour * 60 * 60) + (sleepTimeMinutes * 60))
      
      let wakeupTimeDate = Date().getTodaysDateFor(timeString: wakeupTime)
      let wakeupTimeHour = calendar.component(.hour, from: wakeupTimeDate)
      let wakeupTimeMinutes = calendar.component(.minute, from: wakeupTimeDate)
      
      sleepTimeSlider.endPointValue = CGFloat((wakeupTimeHour * 60 * 60) + (wakeupTimeMinutes * 60))
    } else {
      sleepTimeSlider.startPointValue = 24 * 60 * 60
      sleepTimeSlider.endPointValue = 8 * 60 * 60
    }
    
    updateClockTexts(sleepTimeSlider)
  }
  private func adjustValue(value: inout CGFloat) {
    let minutes = value / 60
    let adjustedMinutes =  ceil(minutes / 5.0) * 5
    value = adjustedMinutes * 60
  }
  private func setupUI() {
    let dayInSeconds = 24 * 60 * 60
    sleepTimeSlider.maximumValue = CGFloat(dayInSeconds)
    sleepTimeSlider.startThumbImage = UIImage(named: "Bedtime")
    sleepTimeSlider.endThumbImage = UIImage(named: "Wake")
    
    bedTimeTitleLabel.text = "Default_BedTime_Title_Label".localiz()
    wakeUpTimeTitleLabel.text = "Default_WakeUpTime_Title_Label".localiz()
    setTimeDescriptionLabel.text = "Default_SleepTime_Description".localiz()
    
    [setTimeDescriptionLabel, bedTimeLabel, wakeupTimeLabel, sleepDurationLabel].forEach{$0?.textColor = SColor.text.value}
    hourImage.tintColor = SColor.text.value
    
    view.backgroundColor = SColor.background.value
    
    saveButton.backgroundColor = SColor.orange.value
    saveButton.setTitle("Save_Button_Title".localiz(), for: .normal)
  }
  @IBAction func updateClockTexts(_ sender: AnyObject) {
    adjustValue(value: &sleepTimeSlider.startPointValue)
    adjustValue(value: &sleepTimeSlider.endPointValue)
    
    let bedtime = TimeInterval(sleepTimeSlider.startPointValue)
    let bedtimeDate = Date(timeIntervalSinceReferenceDate: bedtime)
    bedTimeLabel.text = dateFormatter.string(from: bedtimeDate)
    
    let wake = TimeInterval(sleepTimeSlider.endPointValue)
    let wakeDate = Date(timeIntervalSinceReferenceDate: wake)
    wakeupTimeLabel.text = dateFormatter.string(from: wakeDate)
    
    let duration = wake - bedtime
    let durationDate = Date(timeIntervalSinceReferenceDate: duration)
    dateFormatter.dateFormat = "HH:mm"
    sleepDurationLabel.text = dateFormatter.string(from: durationDate)
    dateFormatter.dateFormat = "hh:mm a"
  }
  @IBAction func saveButtonPressed(_ sender: Any) {
    let bedtime = TimeInterval(sleepTimeSlider.startPointValue)
    let bedtimeHour = Int(bedtime / 60 / 60)
    let bedtimeHourString = bedtimeHour < 10 ? "0\(bedtimeHour)" : "\(bedtimeHour)"
    let bedtimeMinute = Int(bedtime / 60) % 60
    let bedtimeMinuteString = bedtimeMinute < 10 ? "0\(bedtimeMinute)" : "\(bedtimeMinute)"

    let wake = TimeInterval(sleepTimeSlider.endPointValue)
    let wakeupTimeHour = Int(wake / 60 / 60)
    let wakeupTimeHourString = wakeupTimeHour < 10 ? "0\(wakeupTimeHour)" : "\(wakeupTimeHour)"
    let wakeupTimeMinute = Int(wake / 60) % 60
    let wakeupTimeMinuteString = wakeupTimeMinute < 10 ? "0\(wakeupTimeMinute)" : "\(wakeupTimeMinute)"

    let sleepTemp = "\(bedtimeHourString):\(bedtimeMinuteString)"
    let wakeTemp = "\(wakeupTimeHourString):\(wakeupTimeMinuteString)"
		userModel?.sleepTime = sleepTemp
		userModel?.wakeupTime = wakeTemp
		AnalyticLogProvider.logBedTime(hostName: NSStringFromClass(type(of: self)), functionName: "saveButtonPressed", wakeTime: wakeTemp, sleepTime: sleepTemp)
    delegate?.didSaveSleepTime(userModel: userModel)
    dismissSemiModalView()
  }
}
