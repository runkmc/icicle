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
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var toggleSwitch: UISegmentedControl!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var hourlyLabels: UIView!
    @IBOutlet weak var dailyLabels: UIView!
    
    var locationService: LocationService = CurrentLocationService.instance
    var weather: WeatherData? = nil
    let hourlyHelper = HourlyCollectionHelper(weather: nil)
    let dailyHelper = DailyCollectionHelper(weather:nil)
    let headerAnimator = UIDynamicAnimator()
    var collectionAnimator: UIDynamicAnimator!
    let hourlyLayout:RotatingLayout = {
        let l = RotatingLayout()
        l.itemSize = CGSize(width: 150, height: 300)
        return l
    }()
    let dailyLayout:RotatingLayout = {
        let l = RotatingLayout()
        l.itemSize = CGSize(width: 200, height: 300)
        return l
    }()
    
    override func viewDidLoad() {
        // put everything in place
        super.viewDidLoad()
        self.headerAnimator.delegate = self
        self.dailyCollectionView.isHidden = true
        self.dailyLabels.isHidden = true
        self.scrollView.isScrollEnabled = false
        self.hourlyCollectionView.isHidden = true
        self.hourlyLabels.isHidden = true
        self.toggleSwitch.isHidden = true
        // setup both collection views
        self.hourlyCollectionView.collectionViewLayout = self.hourlyLayout
        self.hourlyCollectionView.delegate = self.hourlyHelper
        self.hourlyCollectionView.dataSource = self.hourlyHelper
        let hournib = UINib(nibName: "HourlyCollectionViewCell", bundle: Bundle.main)
        self.hourlyCollectionView.register(hournib, forCellWithReuseIdentifier: "hour")
        self.dailyCollectionView.collectionViewLayout = self.dailyLayout
        self.dailyCollectionView.delegate = self.dailyHelper
        self.dailyCollectionView.dataSource = self.dailyHelper
        let daynib = UINib(nibName: "DailyCollectionViewCell", bundle: Bundle.main)
        self.dailyCollectionView.register(daynib, forCellWithReuseIdentifier: "day")
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
                    
                    self?.hourlyHelper.weather = weather
                    self?.dailyHelper.weather = weather
                    self?.locationName.text = weather.location.name
                    
                    if let icon = weather.hours.first?.icon, let header = self?.headerBackground {
                        let gradient = gradientFor(weather: icon, view: header)
                        self?.headerBackground.layer.addSublayer(gradient)
                        header.bringSubview(toFront: self!.locationName)
                        print("gradient added")
                    }

                    self?.hourlyCollectionView.reloadData()
                    self?.hourlyLayout.addSpringyness()
                    self?.dailyCollectionView.reloadData()
                    self?.dailyLayout.addSpringyness()
                }

                if self != nil {
                    let headerSnapper = UISnapBehavior(item: (self?.headerBackground)!, snapTo: CGPoint(x: self!.view.frame.width / 2, y:105))
                    headerSnapper.damping = 0.65
                    self?.headerAnimator.addBehavior(headerSnapper)
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
    
    @IBAction func switchToggled(_ sender: Any) {
        let toggle = sender as! UISegmentedControl
        switch toggle.selectedSegmentIndex {
        case 0:
            self.dailyCollectionView.isHidden = true
            self.dailyLabels.isHidden = true
            
            self.hourlyCollectionView.isHidden = false
            self.hourlyLabels.isHidden = false
        default:
            self.hourlyCollectionView.isHidden = true
            self.hourlyLabels.isHidden = true
            
            self.dailyLabels.isHidden = false
            self.dailyCollectionView.isHidden = false
        }
    }
}

extension WeatherViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        self.hourlyCollectionView.isHidden = false
        self.hourlyLabels.isHidden = false
        self.toggleSwitch.isHidden = false
        print("pausing")
        self.headerBackgroundTopConstraint.constant = 0
    }
}
