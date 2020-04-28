//
//  UIApplicationExtensions.swift
//  SwiftLocalNotification
//
//  Created by Salar Soleimani on 2020-04-01.
//  Copyright © 2020 Salar Soleimani. All rights reserved.
//

import UIKit

extension UIApplication {
  private var topViewController: UIViewController? {
    var vc = keyWindow?.rootViewController
    
    while let presentedVC = vc?.presentedViewController {
      vc = presentedVC
    }
    
    return vc
  }
  
  func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
    topViewController?.present(viewController, animated: animated, completion: completion)
  }
}
