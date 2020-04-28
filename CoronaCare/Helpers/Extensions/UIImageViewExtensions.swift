//
//  UIImageViewExtensions.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
  func setImageWithUrl(_ url: String) {
    if let url = URL(string: url) {
      self.sd_setImage(with: url)
    }
  }
}
