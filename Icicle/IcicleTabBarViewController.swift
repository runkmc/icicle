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
        let weatherController = WeatherViewController()
        
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image:UIImage(named:"settingsOff"), selectedImage: UIImage(named:"settingsOn"))
        locationsController.tabBarItem = UITabBarItem(title: "Locations", image:UIImage(named:"locationsOff"), selectedImage:UIImage(named:"locationsOn"))
        weatherController.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(named:"weatherOff"), selectedImage: UIImage(named:"weatherOn"))
        self.viewControllers = [weatherController, locationsController, settingsController]
        
        let bar = self.tabBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
