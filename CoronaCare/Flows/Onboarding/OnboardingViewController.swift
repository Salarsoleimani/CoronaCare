//
//  OnboardingViewController.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/26/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import SwiftUI
import ConcentricOnboarding
class OnboardingViewController: UIHostingController<ConcentricOnboardingView> {
    var navigator: OnboardingNavigator!
    init(navigator: OnboardingNavigator) {
        self.navigator = navigator
			let count = 9
        let pages = (0...count-1).map { i in
            AnyView(PageView(title: MockData.titles(count)[i], imageName: MockData.imageNames(count)[i], header: MockData.headers(count)[i], content: MockData.contentStrings(count)[i], textColor: MockData.textColors[i]))
        }
        var onboarding = ConcentricOnboardingView(pages: pages, bgColors: MockData.colors)
        onboarding.insteadOfCyclingToFirstPage = {
            navigator.toPermissions()
        }
        
        super.init(rootView: onboarding)
        
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
