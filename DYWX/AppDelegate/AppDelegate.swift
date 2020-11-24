//
//  AppDelegate.swift
//  DYWX
//
//  Created by 王武 on 2020/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let root = WYTabBarController()
        self.window?.rootViewController = root
        
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

