//
//  AppDelegate.swift
//  Alias
//
//  Created by Kapitan Kanapka on 04.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var initialViewController :UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        let launchViewController = GameSetupViewController()
        
        let navigationController = UINavigationController(rootViewController: launchViewController)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
        
        return true
    }
}

