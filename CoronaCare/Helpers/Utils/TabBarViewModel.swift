////
////  TabBarViewModel.swift
////  VirusCare
////
////  Created by Behrad Kazemi on 3/11/20.
////  Copyright © 2020 BEKApps. All rights reserved.
////
//
//import Foundation
//import BEKCurveTabbar
//struct TabBarViewModel: BEKTabBarViewModelType {
//
//  public var heightRatio: CGFloat = CGFloat(HeightRatios.bestSize.rawValue)
//  public let containerColor: UIColor = .white
//  public let hideTitle: Bool = true
//  public let animationDuration: CGFloat = 0.1
//  public let animated: Bool = true
//  public let shadowColor: UIColor = UIColor(white: 0, alpha: 0.3)
//  public let shadowRadius: CGFloat = 32
//  public let containerBorderWidth: CGFloat = 0.0
//  public let containerBorderColor: UIColor = .clear
//  public let selectedTextColor: UIColor = UIColor(red: 0.353, green: 0.784, blue: 1, alpha: 1.0)
//  public let selectedTextFont: UIFont = .systemFont(ofSize: 13)
//  public let normalTextColor: UIColor = .lightGray
//  public let normalTextFont: UIFont = .systemFont(ofSize: 11)
//  public let topCornerRadius: CGFloat = HeightRatios.bestSize.cornerRadius()
//  public let bottomCornerRadius: CGFloat = HeightRatios.bestSize.cornerRadius()
//  public let containerInsets: UIEdgeInsets = HeightRatios.bestSize.containerInsets()
//  public let selectionCircleRadius: CGFloat = HeightRatios.bestSize.circleRadius()
//  public let selectionCircleBorderWidth: CGFloat = 0.0
//  public let selectionCircleBorderColor: UIColor = .clear
//  public let selectionCircleBackgroundColor: UIColor = UIColor(red: 0.353, green: 0.784, blue: 1, alpha: 1.0)
//  public let textOffset: CGFloat = 0
//  public let animationSpeed: CGFloat = 1.0
//  public init() {}
//}
//
//public enum HeightRatios: Float {
//    case iPhone = 0.12
//    case iPhoneX = 0.1201
//    case iPad = 0.09
//    case notDetermined = 0.2
//    static let bestSize: HeightRatios = {
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            switch UIScreen.main.nativeBounds.height {
//                case 2436:
//                     return .iPhoneX
//
//                case 2688:
//                    return .iPhoneX
//
//                case 1792:
//                    return .iPhoneX
//
//                default:
//                    return .iPhone
//                }
//        case .pad:
//            return .iPad
//        default:
//            return .notDetermined
//        }
//    }()
//
//    func circleRadius() -> CGFloat{
//        return self == HeightRatios.iPhoneX ? 32 : 28
//    }
//
//    func margin() -> CGFloat{
//        return self == HeightRatios.iPhoneX ? 10 : 5
//    }
//
//    func containerInsets() -> UIEdgeInsets{
//        return self == HeightRatios.iPhoneX ? UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
//    }
//
//    func cornerRadius() -> CGFloat{
//        return self == HeightRatios.iPhoneX ? 46 : 10
//    }
//
//}
