//
//  WeatherViewController.swift
//  Icicle
//
//  Created by Kevin McGladdery on 8/23/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var locationHeadLabel: UILabel!
    @IBOutlet weak var timeHeadLabel: UILabel!
    @IBOutlet weak var dateHeadLabel: UILabel!
    @IBOutlet weak var currentConditionsHead: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!

    var locationService: LocationService = CurrentLocationService.instance
    var weather: WeatherData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("got to view will appear")
        weatherFetcher(locationService: locationService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
                if let weather = result.successValue() {
                    self?.weather = weather
                    self?.weatherDescription.attributedText = self?.setParagraph(text: weather.fullSummary)
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.weatherDescription.text = nil
        print("did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setParagraph(text:String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.10
        return NSAttributedString(string: text, attributes: [NSParagraphStyleAttributeName:paragraphStyle])
    }
}
