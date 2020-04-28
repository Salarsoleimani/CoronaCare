//
//  HomeViewController.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-04.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	@IBOutlet weak var newsCollectionView: UICollectionView!
	@IBOutlet weak var blurBackground: UIVisualEffectView!
	@IBOutlet weak var titleLabel: UILabel!
	
	var currentLanguage = LanguageManager.shared.currentLanguage
	
	var homeNetworkResponse: [HomeNetworkModel] {
		LanguageManager.shared.currentLanguage.asHomeJSON()
	}
	let navigator: HomeNavigator
	
	init(navigator: HomeNavigator) {
		self.navigator = navigator
		super.init(nibName: "HomeViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupNewsCollectionView()
		getHome()
	}
	private func setupUI() {
		titleLabel.text = "Home_Navigation_Title".localiz()
		blurBackground.layer.cornerRadius = blurBackground.bounds.size.height / 2
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if currentLanguage != LanguageManager.shared.currentLanguage {
			currentLanguage = LanguageManager.shared.currentLanguage
			getHome()
		}
	}
	private func getHome() {
		newsCollectionView.reloadData()
	}
	private func setupNewsCollectionView() {
		newsCollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
		newsCollectionView.delegate = self
		newsCollectionView.dataSource = self
	}
	
}

