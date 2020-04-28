//
//  Error+PopUpCover.swift
//  OKala
//
//  Created by Behrad Kazemi on 12/9/19.
//  Copyright © 2019 Golrang. All rights reserved.
//

import Foundation
import UIKit
import Domain
extension Error {
  func asPopUpCoverViewModel() -> PopUpCoverViewModel{
    let error = self as NSError
    
    let descriptionText: String
    switch error.code {
    case -1004:
      descriptionText = "ConnectionProblem".localiz()
    default:
      descriptionText = error.userInfo["message"] as? String ?? "UnknownError".localiz()
    }
    let color = UIColor.systemOrange
    return PopUpCoverViewModel(image: UIImage(named: "Warning")!, title: "AnErrorOccured".localiz() , description: descriptionText, imageColor: color)
  }
}
