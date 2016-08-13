//
//  AppDelegate.swift
//  Icicle
//
//  Created by Kevin McGladdery on 3/22/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let tabBarController = UITabBarController()
        let settingsController = SettingsViewController()
        let locationsController = LocationsViewController()
        let todayController = TodayViewController()
        let weekController = WeekViewController()
        
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image:UIImage(named:"settingsOff"), selectedImage: UIImage(named:"settingsOn"))
        locationsController.tabBarItem = UITabBarItem(title: "Locations", image:UIImage(named:"locationsOff"), selectedImage:UIImage(named:"locationsOn"))
        todayController.tabBarItem = UITabBarItem(title: "Today", image:UIImage(named:"todayOff"), selectedImage:UIImage(named:"todayOn"))
        weekController.tabBarItem = UITabBarItem(title: "This Week", image:UIImage(named:"weekOff"), selectedImage:UIImage(named:"weekOn"))
        tabBarController.viewControllers = [todayController, weekController, locationsController, settingsController]
        
        let bar = tabBarController.tabBar
        bar.tintColor = IcicleColor.peach
        bar.barTintColor = IcicleColor.lightGrey
        
        window?.rootViewController = tabBarController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
