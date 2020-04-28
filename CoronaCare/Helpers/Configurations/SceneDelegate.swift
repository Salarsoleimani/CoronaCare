//
//  SceneDelegate.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 2/24/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import UIKit
import SwiftUI
import AnalyticPlatform

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(windowScene: windowScene)
		setupApplication()
	}
	private func setupApplication() {
		Application.shared.configureMainInterface(in: window!)
		Application.shared.setupApplicationConfigurations()
		
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		Application.shared.refresh()
	}
	
	func sceneWillResignActive(_ scene: UIScene) {

	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
    AppAnalytics.shared.setAppOpenedCount()
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		Application.shared.scheduleBackgroundTasks()
	}
}

