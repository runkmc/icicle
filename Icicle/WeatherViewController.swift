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
    var location: Location?
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerBackgroundTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var weatherDescription: UILabel!
    let animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let locService = CurrentLocationService.instance
        print("got to view will appear")
        weatherFetcher(locationService: locService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
                if let weather = result.successValue() {
                    self?.locationName.text = self?.location?.name ?? "Current Location"
                    self?.weatherDescription.text = weather.fullSummary
                }
                
                
                
                
                if self != nil {
                    let headerSnapper = UISnapBehavior(item: (self?.headerBackground)!, snapTo: CGPoint(x: self!.view.frame.width / 2, y:105))
                    headerSnapper.damping = 0.65
                    self?.animator.addBehavior(headerSnapper)
                }
                self?.scrollView.isScrollEnabled = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        headerBackgroundTopConstraint.constant = -210
        self.view.layoutSubviews()
        self.animator.removeAllBehaviors()
        print("did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension WeatherViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        self.headerBackgroundTopConstraint.constant = 0
    }
}
