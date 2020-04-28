//
//  NewsDetailController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SafariServices

class NewsDetailController: UIViewController {
  private let newsDetailModel: HomeNetworkModel!
  
  @IBOutlet weak var imageBackgroundContainer: UIView!
  @IBOutlet weak var newsImageView: UIImageView!
  @IBOutlet weak var newsTitleLabel: UILabel!
  @IBOutlet weak var newsDescriptionLabel: UILabel!
  
  @IBOutlet weak var seeMoreShadowContainer: UIView!
  @IBOutlet weak var seeMoreContainer: UIView!
  @IBOutlet weak var headlineLabel: UILabel!
  private let navigator: NewsDetailNavigator
  @IBOutlet weak var mainScrollView: UIScrollView!
  let disposeBag = DisposeBag()
  init(navigator: NewsDetailNavigator, model: HomeNetworkModel) {
    self.newsDetailModel = model
    self.navigator = navigator
    
    super.init(nibName: "NewsDetailController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imageBackgroundContainer.roundCorners(corners: [.topLeft, .topRight], radius: 12)
    imageBackgroundContainer.clipsToBounds = true
    
    setupUI()
  }
  override func viewDidAppear(_ animated: Bool) {
    Vibrator.vibrate(hardness: 5)
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.5) {
      self.seeMoreContainer.alpha = 1
      self.seeMoreShadowContainer.alpha = 1
    }
    mainScrollView.rx.contentOffset.asObservable().subscribe(onNext: { [unowned self](point) in
      if point.y < -150 {
        Vibrator.vibrate(hardness: 4)
        self.dismiss(animated: true, completion: nil)
      }
    }).disposed(by: disposeBag)
  }
  
  @IBAction func seeMore(_ sender: Any) {
    if let url = URL(string: newsDetailModel.src) {
      let vc = SFSafariViewController(url: url)
      present(vc, animated: true)
    }
  }
  
  func setupUI() {
    newsTitleLabel.text = newsDetailModel.title
    newsImageView.setImageWithUrl(newsDetailModel.thumbnail)
    newsDescriptionLabel.text = newsDetailModel.description
    headlineLabel.text = newsDetailModel.headline
    seeMoreContainer.alpha = 0
    seeMoreShadowContainer.alpha = 0
    mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 128, right: 0)
    seeMoreShadowContainer.dropShadow(color: .black, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 10, cornerRadius: 32)
  }
  
  @IBAction private func closeButtonPressed(_ sender: UIButton) {
    navigator.close(vc: self)
  }
}
