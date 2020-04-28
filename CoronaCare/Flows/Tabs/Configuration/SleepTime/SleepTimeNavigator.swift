//
//  SleepTimeNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import SemiModalViewController
import Domain

final class SleepTimeNavigator: Navigator {
  
  func setup(_ vc: ConfigurationViewController, userInfo: UserInfoModel?) {
		AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
    let sleepVc = SleepTimeController(navigator: self)
    sleepVc.userModel = userInfo
    sleepVc.delegate = vc
    let options: [SemiModalOption : Any] = [
      SemiModalOption.traverseParentHierarchy : true,
      SemiModalOption.pushParentBack          : false,
      SemiModalOption.animationDuration       : 0.25,
      SemiModalOption.parentAlpha             : 0.25,
      SemiModalOption.parentScale             : 0.8,
      SemiModalOption.shadowOpacity           : 0.7,
      SemiModalOption.disableCancel           : true
    ]
    
    let width = StaticConstants.mainScreenWidth
    let height = 40 + 4 + 50 + 4 + (width * 0.8) + 12 + 40 + 20 + 20
    sleepVc.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

    vc.presentSemiViewController(sleepVc, options: options, completion: {
        print("Completed!")
    }, dismissBlock: {
        print("Dismissed!")
    })
  }
}
