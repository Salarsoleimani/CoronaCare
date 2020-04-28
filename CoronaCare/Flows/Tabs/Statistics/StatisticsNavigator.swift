//
//  StatisticsNavigator.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-26.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Domain
final class StatisticsNavigator: Navigator {
    func setup(dataBase: DataBaseManagerInterface) -> UIViewController {
			AnalyticLogProvider.logNavigator(name: NSStringFromClass(type(of: self)), functionName: "setup")
        let vc = StatisticsViewController(navigator: self)
      vc.viewModel = StatistisViewModel(navigator: self, dataBase: dataBase)
        navigationController.pushViewController(vc, animated: true)
        return vc
    }
}
