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
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerBackgroundTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var weatherDescription: UILabel!

    var locationService: LocationService = CurrentLocationService.instance
    var weather: WeatherData? = nil
    
    override func viewDidLoad() {
        // put everything in place
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false
        // setup both collection views
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("got to view will appear")
        weatherFetcher(locationService: locationService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
                if let weather = result.successValue() {
                    self?.weather = weather
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineHeightMultiple = 1.15
                    let description = NSAttributedString(string: weather.fullSummary, attributes:
                        [NSFontAttributeName:UIFont(name:"FiraSans-Book", size:18.0)!,
                         NSParagraphStyleAttributeName:paragraphStyle])
                    self?.weatherDescription.attributedText = description
                    
                    self?.locationName.text = weather.location.name
                }

            self?.scrollView.isScrollEnabled = true
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        headerBackgroundTopConstraint.constant = -210
        self.weatherDescription.text = nil
        self.view.layoutSubviews()
        self.headerAnimator.removeAllBehaviors()
        print("did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
