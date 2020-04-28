//
//  IAPService.swift
//  VirusCase
//
//  Created by Salar Soleimani on 2020-03-16.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import StoreKit
import AnalyticPlatform

class IAPService: NSObject {
  
  private override init() {}
  static let shared = IAPService()
  
  var configurationPageDelegate: ConfigurationViewControllerDelegate?
  var products = [SKProduct]()
  
  let paymentQueue = SKPaymentQueue.default()
  
  func getProducts() {
    let products: Set = [IAPProducts.oneDollar.rawValue,
                         IAPProducts.threeDollar.rawValue,
                         IAPProducts.fiveDollar.rawValue,
                         IAPProducts.tenDollar.rawValue,
                         IAPProducts.twentyDollar.rawValue,
                         IAPProducts.finftyDollar.rawValue,
                         IAPProducts.hundredDollar.rawValue,
                         IAPProducts.removeAds.rawValue]
    let request = SKProductsRequest(productIdentifiers: products)
    request.delegate = self
    request.start()
    paymentQueue.add(self)
  }
  
  func purchase(product: IAPProducts, configurationPageDelegate: ConfigurationViewControllerDelegate? = nil) {
    guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
    self.configurationPageDelegate = configurationPageDelegate
    let payment = SKPayment(product: productToPurchase)
    paymentQueue.add(payment)
  }
  
  func restorePurchases(_ configurationPageDelegate: ConfigurationViewControllerDelegate? = nil) {
    print("restore purchases")
    paymentQueue.restoreCompletedTransactions()
  }
  
}

extension IAPService: SKProductsRequestDelegate {
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    products = response.products
    for product in response.products {
      print(product.localizedTitle)
    }
  }
  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
    
  }
}

extension IAPService: SKPaymentTransactionObserver {
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      if transaction.transactionState == .purchased, transaction.payment.productIdentifier == IAPProducts.removeAds.rawValue {
        AppAnalytics.shared.adsRemoved()
        configurationPageDelegate?.didAdsRemoved { }
      }
      print(transaction.transactionState.status(), transaction.payment.productIdentifier)
      if transaction.transactionState == .restored, transaction.payment.productIdentifier == IAPProducts.removeAds.rawValue {
        AppAnalytics.shared.adsRemoved()
        configurationPageDelegate?.didAdsRemoved { }
      }
      switch transaction.transactionState {
      case .purchasing: break
      default: queue.finishTransaction(transaction)
      }
    }
  }
}

extension SKPaymentTransactionState {
  func status() -> String {
    switch self {
    case .deferred: return "deferred"
    case .failed: return "failed"
    case .purchased: return "purchased"
    case .purchasing: return "purchasing"
    case .restored: return "restored"
    }
  }
}

