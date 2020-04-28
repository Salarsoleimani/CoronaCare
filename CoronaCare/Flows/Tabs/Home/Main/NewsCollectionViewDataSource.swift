//
//  NewsCollectionViewDataSource.swift
//  VirusCare
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import Hero
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return homeNetworkResponse.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NewsCell
    cell.layer.cornerRadius = 15
    cell.configure(homeNetworkResponse[indexPath.item])
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigator.toNewsDetail(homeNetworkResponse[indexPath.item], homeVc: self)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: StaticConstants.mainScreenWidth * 0.94, height: StaticConstants.mainScreenWidth * 1.15)
  }
  
}
