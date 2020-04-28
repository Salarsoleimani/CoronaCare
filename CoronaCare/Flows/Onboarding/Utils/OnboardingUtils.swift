//
//  OnboardingUtils.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/25/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import SwiftUI

struct PageView: View {
  var title: String
  var imageName: String
  var header: String
  var content: String
  var textColor: Color
  
  let imageWidth: CGFloat = 150
  let textWidth: CGFloat = 350
  
  var body: some View {
    let size = UIImage(named: imageName)!.size
    let aspect = size.width / size.height
    
    return
      VStack(alignment: .center, spacing: 16) {
        Text(title)
          .font(Font.system(size: 40, weight: .bold, design: .rounded))
          .foregroundColor(textColor)
          .frame(width: textWidth)
          .multilineTextAlignment(.center)
        Image(imageName)
          .resizable()
          .aspectRatio(aspect, contentMode: .fill)
          .frame(width: imageWidth, height: imageWidth)
          .cornerRadius(40)
          .clipped()
        VStack(alignment: .center, spacing: 5) {
          Text(header)
            .font(Font.system(size: 25, weight: .bold, design: .rounded))
            .foregroundColor(textColor)
            .frame(width: 300, alignment: .center)
            .multilineTextAlignment(.center)
          Text(content)
            .font(Font.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(textColor)
            .frame(width: 300, alignment: .center)
            .multilineTextAlignment(.center)
        }
      }.padding(16)
  }
}

struct MockData {
  
  static let titles = { (size) in
    return (1...size).compactMap { (index) in
      return "onboarding-title\(index)".localiz()
    }
  }
  static let headers = { (size) in
    return (1...size).compactMap { (index) in
      return "onboarding-header\(index)".localiz()
    }
  }
  static let contentStrings = { (size) in
    return (1...size).compactMap { (index) in
      return "onboarding-body\(index)".localiz()
    }
  }
  static let imageNames = { (size) in
    return (1...size).compactMap { (index) in
      return "screen \(index)"
    }
  }
  
  static let colors = [
    "FCE38A",
    "FFFFFF",
    "95E1D3",
    "FCE38A",
    "95E1D3",
    "fda085",
    "FFFFFF",
    "95E1D3",
    "EAFFD0"
    ].map{ Color(hex: $0) }
  
  static let textColors = [
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A",
    "4A4A4A"
    ].map{ Color(hex: $0) }
  
  
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    var rgbValue: UInt64 = 0
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    
    self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
  }
}
