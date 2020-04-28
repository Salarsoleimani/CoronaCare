//
//  AppEngineDelegate.swift
//  Domain
//
//  Created by Behrad Kazemi on 3/29/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation

public protocol AppEngineDelegate: AppEngineLocationDelegate, AppEngineNotificaitonDelegate {
	
}

public protocol AppEngineLocationDelegate{
	func locationUpdates()
}

public protocol AppEngineNotificaitonDelegate{
	
}
