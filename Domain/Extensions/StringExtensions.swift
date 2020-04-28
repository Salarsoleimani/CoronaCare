//
//  StringExtensions.swift
//  Domain
//
//  Created by Salar Soleimani on 2020-03-27.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public extension String {
  
  ///
  /// Localize the current string to the selected language
  ///
  /// - returns: The localized string
  ///

  func localiz(comment: String = "") -> String {
    guard let currentLang = UserDefaults.standard.string(forKey: LanguageManagerConstants.defaultsKeys.selectedLanguage) else {
    fatalError("Did you set the default language for the app?")
    }
    guard let bundle = Bundle.main.path(forResource: Languages(rawValue: currentLang)!.rawValue, ofType: "lproj") else {
      return NSLocalizedString(self, comment: comment)
    }
    
    let langBundle = Bundle(path: bundle)
    return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
  }
  
}
fileprivate enum LanguageManagerConstants {
  
  enum defaultsKeys {
    static let selectedLanguage = "LanguageManagerSelectedLanguage"
  }
}
