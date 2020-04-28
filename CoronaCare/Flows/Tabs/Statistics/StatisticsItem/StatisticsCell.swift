//
//  StatisticsCell.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/12/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import BEKMultiCellTable
class StatisticsCell: UITableViewCell {
  var viewModel: StatisticsItemViewModel?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var progressContainer: UIView!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var lowLevelLabel: UILabel!
  @IBOutlet weak var regularLevelLabel: UILabel!
  @IBOutlet weak var perfectLevelLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var shadowContainer: UIView!
  @IBOutlet weak var iconImageView: UIImageView!
  override func awakeFromNib() {
    super.awakeFromNib()
    containerView.backgroundColor = SColor.secondBackground.value

    [lowLevelLabel, regularLevelLabel, perfectLevelLabel].forEach { (item) in
      item?.textColor = SColor.text.value
    }
    titleLabel.textColor = SColor.customWithDarkModeString(hexStringForDarkMode: "FCFCFC", hexStringForLightMode: "353535", alpha: 1.0).value
    quoteLabel.textColor = SColor.customWithDarkModeString(hexStringForDarkMode: "ececec", hexStringForLightMode: "121212", alpha: 1.0).value
  }
  
}

extension StatisticsCell: BEKBindableCell {
  typealias ViewModeltype = StatisticsItemViewModel
  func bindData(withViewModel viewModel: StatisticsItemViewModel) {
    self.viewModel = viewModel
    titleLabel.text = viewModel.model.title
    progressBar.setProgress(0, animated: false)
    progressBar.setProgress(viewModel.progress, animated: true)
    quoteLabel.text = viewModel.qoute
    progressBar.progressTintColor = viewModel.eventState.asSColor().value
    iconImageView.image = UIImage(named: viewModel.model.model.asEventType().getImageName())
  }
}
