//
//  StatiticsOverViewCell.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/14/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import BEKMultiCellTable
import Domain

class StatiticsOverViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var quoteLabel: UILabel!
  var viewModel: Float!
  override func awakeFromNib() {
        super.awakeFromNib()
    titleLabel.textColor = SColor.customWithDarkModeString(hexStringForDarkMode: "FCFCFC", hexStringForLightMode: "353535", alpha: 1.0).value
    quoteLabel.textColor = SColor.customWithDarkModeString(hexStringForDarkMode: "FCFCFC", hexStringForLightMode: "353535", alpha: 1.0).value
    }
  
}
extension StatiticsOverViewCell: BEKBindableCell {
  typealias ViewModeltype = Float
  func bindData(withViewModel viewModel: Float) {
    self.viewModel = viewModel
    titleLabel.text = "Statistic_Navigation_Title".localiz()
    let random = Int.random(in: 0..<4)
    quoteLabel.text = String(format: "Statistics_Title_Qoute_\(random)".localiz(), Int(viewModel * 100))
    
  }
}
