//
//  NotificationPlatformTests.swift
//  NotificationPlatformTests
//
//  Created by Behrad Kazemi on 3/17/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import XCTest

@testable import NotificationPlatform
@testable import Domain

class NotificationPlatformTests: XCTestCase {
  
  var manager: NotificationManagerInterface!
  override func setUp() {
    super.setUp()
    manager = NotificationManager.shared
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    manager = nil
    super.tearDown()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testSettingEvent() {
    manager.resetFactory()
    let event = HandsCareEvent()
    let cycle = 1.0
    let config = ScheduledNotificationConfigModel(eventId: event.id, scheduledCycleTime: cycle, repeatCount: 1)
    manager.set(event: event, configuration: config)
    
    manager.upNextNotifications(forEvent: event) { (items) in
      //        XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
      XCTAssert(items.count > 0, "Notification not properly")
      let item = items.first!
      
      XCTAssert(item.fireDate.timeIntervalSinceNow <= cycle * 60, "Notification not properly")
    }
    
  }
  
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
