//
//  BekSasDate.swift
//  NotificationPlatform
//
//  Created by Salar Soleimani on 2020-03-17.
//  Copyright © 2020 BEKApps. All rights reserved.
//

public extension Date {
  func getTodaysDateFor(timeString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let dateFromString = formatter.date(from: timeString) ?? Date()
    let hour = Calendar.current.component(.hour, from: dateFromString)
    let minute = Calendar.current.component(.minute, from: dateFromString)
    let todayDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()) ?? Date()
    return todayDate
  }
  func tommorowDate(fromDate: Date) -> Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: fromDate) ?? Date()
  }
  func getTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: self)
  }
  func getTimeInDouble() -> Double {
    Date.stringTimeToDouble(timeString: getTimeString())
  }
  static func stringTimeToDouble(timeString: String) -> Double {
    let timeHourAndMinute = timeString.components(separatedBy: ":")
    if timeHourAndMinute.count == 2, let timeHour = timeHourAndMinute.first, let timeHourInt = Double(timeHour), let timeMinuteInt = Double(timeHourAndMinute[1]) {
      return timeHourInt + (timeMinuteInt / 60)
    }
    return -1
  }
	
  func isBetween(wakeTime: String, sleepTime: String) -> Bool {
		let firstTimeDouble = Date.stringTimeToDouble(timeString: wakeTime)
		let secondTimeDouble = Date.stringTimeToDouble(timeString: sleepTime)
		let selfTimeDouble = getTimeInDouble()
		
		if firstTimeDouble > secondTimeDouble {
			return selfTimeDouble > secondTimeDouble && selfTimeDouble < firstTimeDouble
		}
    return selfTimeDouble > secondTimeDouble || selfTimeDouble < firstTimeDouble
  }
}

