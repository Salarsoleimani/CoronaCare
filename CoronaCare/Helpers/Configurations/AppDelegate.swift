//
//  AppDelegate.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/24/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import UserNotifications
import LocationManager
import NotificationCenter
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  private func setupApplication() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    Application.shared.configureMainInterface(in: window)
    Application.shared.setupApplicationConfigurations()
    self.window = window
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  func applicationWillTerminate(_ application: UIApplication) {
    Application.shared.refresh()
  }
  func applicationDidBecomeActive(_ application: UIApplication) {
    
  }
  func applicationWillResignActive(_ application: UIApplication) {
    
  }
  func applicationDidEnterBackground(_ application: UIApplication) {
    
  }
  func applicationDidFinishLaunching(_ application: UIApplication) {
    
  }
  func applicationWillEnterForeground(_ application: UIApplication) {
    
  }
  func applicationSignificantTimeChange(_ application: UIApplication) {
    
  }
  func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
    
  }
}

