//
//  SnoozePickerViewDelegate.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit

extension ConfigurationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return snoozeMinutes.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(snoozeMinutes[row])
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let snooze = snoozeMinutes[row]
    snoozeLabel.text = String(snooze) + "Snooze_Minutes".localiz()
    Utility.saveSnoozeMinutes(snooze)
  }
}
