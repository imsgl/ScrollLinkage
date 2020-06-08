//
//  AppDelegate.swift
//  Scroll.Linkage
//
//  Created by 孙国立 on 2020/6/5.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        self.window?.rootViewController = MainController()
        return true
    }


}

