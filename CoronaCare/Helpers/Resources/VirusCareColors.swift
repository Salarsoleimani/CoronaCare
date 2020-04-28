//
//  VirusCareColors.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-29.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import UIKit

enum SColor {
  case background
  case secondBackground

  case darkBlue
  case ultraLightBlue
  case lightGray
  case darkGray
  case white
  case text
  case error
  case lightBlue
  case lightGreen
  case ovalBlack
  case yelloBackground
  case red
  case green
  case orange
  case yellow
  case mainRed
  case custom(hexString: String, alpha: Double)
  case customWithDarkModeString(hexStringForDarkMode: String, hexStringForLightMode: String, alpha: Double)
  case customWithDarkModeColor(colorForDarkMode: UIColor, colorForLightMode: UIColor, alpha: Double)
  
  func withAlpha(_ alpha: Double) -> UIColor {
    return self.value.withAlphaComponent(CGFloat(alpha))
  }
}

extension SColor {
  
  var value: UIColor {
    var instanceColor = UIColor.clear
    
    switch self {
    case .custom(let hexString, let opacity):
      instanceColor = UIColor(hexString: hexString).withAlphaComponent(CGFloat(opacity))
    case .customWithDarkModeString(let hexStringForDarkMode, let hexStringForLightMode, let opacity):
      instanceColor = UIColor.UITraitCollectionColor(darkModeHexString: hexStringForDarkMode, lightModeHexString: hexStringForLightMode).withAlphaComponent(CGFloat(opacity))
    case .customWithDarkModeColor(let colorForDarkMode, let colorForLightMode, let opacity):
      UIColor.UITraitCollectionColor(darkModeColor: colorForDarkMode, lightModeColor: colorForLightMode).withAlphaComponent(CGFloat(opacity))
    case .darkBlue:
      instanceColor = UIColor(hexString: "#1C2135")
    case .background:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor.black, lightModeColor: UIColor.white)
    case .text:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor(hexString: "#ececec"), lightModeColor: UIColor(hexString: "#9B9B9B"))
    case .darkGray:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor.darkGray, lightModeColor: UIColor.lightGray)
    case .error:
      instanceColor = UIColor(hexString: "#e3342f")
    case .ultraLightBlue:
      instanceColor = UIColor(hexString: "#8794C0")
    case .white:
      instanceColor = UIColor.white
    case .lightGray:
      instanceColor = UIColor(hexString: "#E7E9EE")
    case .lightBlue:
      instanceColor = UIColor(hexString: "#3490dc")
      case .yellow:
        instanceColor = UIColor.yellow
    case .lightGreen:
      instanceColor = UIColor(hexString: "#38c172")
      
    case .ovalBlack:
      instanceColor = UIColor(hexString: "#231F1F")
    case .yelloBackground:
      instanceColor = UIColor(hexString: "#FCE38A")
      
    case .red:
      instanceColor = UIColor.red
    case .mainRed:
      instanceColor = UIColor(red: 255, green: 15, blue: 63, alpha: 1)
    case .green:
      instanceColor = UIColor(hexString: "#178617")
    case .orange:
      instanceColor = UIColor(hexString: "#FF5B00")
    case .secondBackground:
      instanceColor = UIColor.UITraitCollectionColor(darkModeColor: UIColor(white: 0.15, alpha: 0.5), lightModeColor: UIColor(white: 0.85, alpha: 0.5))

    }
    return instanceColor
  }
}

