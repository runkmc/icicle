//
//  WeatherViewController.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/23/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var locationService: LocationService? = nil
    @IBOutlet weak var headerBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let locService = CurrentLocationService.instance
        print("got to view will appear")
        weatherFetcher(locationService: locService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
