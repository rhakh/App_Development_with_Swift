//
//  AppDelegate.swift
//  AppLifeCycle
//
//  Created by Роман Гах on 25.01.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Did Finish Launching");
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("Will Resign Active")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did Enter Background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
            print("Will Enter Foreground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Did Become Active")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Will Terminate")
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


}

