//
//  NewsCell.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Hero

class NewsCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var newsImageView: UIImageView!
  @IBOutlet weak var tapTipLabel: UIView!
  @IBOutlet weak var blackBackground: UIView!
  @IBOutlet weak var blurBackground: UIVisualEffectView!
  @IBOutlet weak var blurSeeMore: UIVisualEffectView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    tapTipLabel.layer.cornerRadius = tapTipLabel.bounds.size.height / 2
    blurSeeMore.layer.cornerRadius = blurSeeMore.bounds.size.height / 2
    
  }
  func configure(_ with: HomeNetworkModel) {
    titleLabel.text = with.title
    descriptionLabel.text = with.headline
    newsImageView.isHidden = false
    newsImageView.setImageWithUrl(with.thumbnail)
    newsImageView.hero.id = String(with.id)
    titleLabel.hero.id = String(with.id) + "title"
    descriptionLabel.hero.id = String(with.id) + "headline"
    blackBackground.hero.id = String(with.id) + "background"
    blurBackground.hero.id = String(with.id) + "headline"
    
  }
  
}
