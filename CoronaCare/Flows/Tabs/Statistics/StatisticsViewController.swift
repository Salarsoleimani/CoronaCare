//
//  StatisticsViewController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-02-26.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import BEKMultiCellTable
import RxCocoa
import RxSwift
import GoogleMobileAds
import NotificationPlatform
import Domain
import Lottie
class StatisticsViewController: UIViewController {
  let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
  
  private let navigator: StatisticsNavigator
  var viewModel: StatistisViewModel!
	var disposeBag = DisposeBag()
  @IBOutlet weak var tableView: BEKMultiCellTable!
  @IBOutlet weak var emptyLabel: UILabel!
  @IBOutlet weak var noContentView: UIView!
  @IBOutlet weak var lottieAnimationContainer: UIView!
  private var animation: AnimationView!
  init(navigator: StatisticsNavigator) {
    self.navigator = navigator
    super.init(nibName: "StatisticsViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindData()
  }
  func bindData(){
    
    let input = StatistisViewModel.Input()
    let output = viewModel.transform(input: input)
    let logger = AnalyticLogProvider()
    let observable = Observable.combineLatest(Observable.just(logger), tableView.rx.contentOffset.asObservable())
    observable.map { [tableView](arg) -> Void in
      let (logger, point) = arg
      let height = tableView?.contentSize.height ?? StaticConstants.mainScreenHeight
      return logger.logScrollingVisit(hostName: "StatisticsViewController", scrollName: "tableView", offset: Float(point.y), contentSize: Float(height))
    }.subscribe().disposed(by: disposeBag)
    output.items.subscribe(onNext: { [tableView](items) in
      let cells = items.compactMap { (viewModelItem) -> BEKGenericCell<StatisticsCell>  in
        return  BEKGenericCell<StatisticsCell>(viewModel: viewModelItem)
      }
      let totalProgress = items.reduce(Float(0)) { (result, itrItem) -> Float in
        return result + itrItem.progress
        } / ((items.count > 0) ? Float(items.count) : 1.0 )
      let titleCell = BEKGenericCell<StatiticsOverViewCell>(viewModel: totalProgress)
      tableView?.push(cell: titleCell)
      tableView?.push(cells: cells)
    }).disposed(by: disposeBag)
    output.showEmpty.do(onNext: { [unowned self](show) in
      if show {
        self.noContentView.alpha = 0
        self.noContentView.isHidden = !show
        self.noContentView.makeAlpha(1).completion {
          self.animation = AnimationView(name: "Empty")
          self.lottieAnimationContainer.contentMode = .scaleAspectFit
          self.lottieAnimationContainer.addSubview(self.animation)
          self.animation.frame = self.lottieAnimationContainer.bounds
          self.animation.loopMode = .repeat(5)
          self.animation.play()
        }.animate()
      }
    }).drive().disposed(by: disposeBag)
  }
  private func setupGoogleAd() {
    bannerView.adUnitID = adBannerStatisticBottom // [TODO] -force change to adBannerStatisticBottom
    bannerView.rootViewController = self
    bannerView.load(GADRequest())
    //bannerView.delegate = self
    addBannerViewToView(bannerView)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if !StaticConstants.isAdsRemoved {
      setupGoogleAd()
    }
		DispatchQueue.main.async {
			self.tableView.removeAll()
			self.bindData()
			self.tableView.reloadData()
		}
  }
  private func setupUI(){
    noContentView.isHidden = true
  }
}
extension BEKMultiCellTable {
	func removeAll(){
		let count = numberOfRows(inSection: 0)
		(0..<count).forEach { (_) in
			remove(cellAtIndex: 0)
		}
	}
}
