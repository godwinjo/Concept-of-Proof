//
//  AppDelegate.swift
//  Concept of Proof
//
//  Created by Godwin on 01/07/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setRootViewController()
        return true
    }
    
    // MARK: Set RootViewController
    func setRootViewController() {
        let homeViewController = HomeTableViewController()
        let navigationcontoller = UINavigationController(rootViewController: homeViewController)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate?.window?.rootViewController = navigationcontoller
        appDelegate?.window?.makeKeyAndVisible()
    }
    
}
