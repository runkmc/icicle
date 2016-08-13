//
//  IcicleTabBarViewController.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/12/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

class IcicleTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let settingsController = SettingsViewController()
        let locationsController = LocationsViewController()
        let todayController = TodayViewController()
        let weekController = WeekViewController()
        
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image:UIImage(named:"settingsOff"), selectedImage: UIImage(named:"settingsOn"))
        locationsController.tabBarItem = UITabBarItem(title: "Locations", image:UIImage(named:"locationsOff"), selectedImage:UIImage(named:"locationsOn"))
        todayController.tabBarItem = UITabBarItem(title: "Today", image:UIImage(named:"todayOff"), selectedImage:UIImage(named:"todayOn"))
        weekController.tabBarItem = UITabBarItem(title: "This Week", image:UIImage(named:"weekOff"), selectedImage:UIImage(named:"weekOn"))
        self.viewControllers = [todayController, weekController, locationsController, settingsController]
        
        let bar = self.tabBar
        bar.tintColor = IcicleColor.peach
        bar.barTintColor = IcicleColor.lightGrey
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
