//
//  SplashViewController.swift
//
//
//  Created by Behrad Kazemi on 11/25/19.
//  Copyright © 2019 BEKApps. All rights reserved.
//

import UIKit
import Stellar

class SplashViewController: UIViewController {
  var viewModel: SplashViewModel!
  
  @IBOutlet weak var launchImage: UIImageView!
  @IBOutlet weak var logoLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    assert(viewModel != nil)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animation { [unowned self] in
      self.viewModel.goToHomePage(handler: nil)
    }
  }

  private func animation(completion: @escaping () -> ()){
    let startingScale = 1 - viewModel.scalePop
    let endingScale = 1 / startingScale
    
    launchImage.delay(1).scaleXY(startingScale, startingScale).duration(0.3).easing(.easeInEaseOut).completion { [launchImage] in
      AppSoundEffects().playPopSound()
      Vibrator.vibrate(hardness: 5)
      launchImage?.image = UIImage(named: "Splash_Last")
    }.then().scaleXY(endingScale, endingScale).then().moveY(-60).snap(1).duration(1).completion {
      completion()
    }.animate()
		logoLabel.delay(1.8).moveY(32).makeAlpha(1).duration(1).animate()
  }
}
