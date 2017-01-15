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
    
    var locationService: LocationService = CurrentLocationService.instance
    var weather: WeatherData? = nil
    let hourlyHelper = HourlyCollectionHelper(weather: nil)
    let animator = UIDynamicAnimator()
    let hourlyLayout:UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 150, height: 300)
        l.scrollDirection = .horizontal
        l.headerReferenceSize = CGSize(width: 145, height: 300)
        l.sectionHeadersPinToVisibleBounds = true
        return l
    }()
    let dailyLayout:UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 150, height: 300)
        l.scrollDirection = .horizontal
        l.headerReferenceSize = CGSize(width: 145, height: 300)
        l.sectionHeadersPinToVisibleBounds = true
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animator.delegate = self
        self.dailyCollectionView.isHidden = true
        self.scrollView.isScrollEnabled = false
        self.hourlyCollectionView.isHidden = true
        self.toggleSwitch.isHidden = true
        self.hourlyCollectionView.collectionViewLayout = self.hourlyLayout
        self.hourlyCollectionView.delegate = self.hourlyHelper
        self.hourlyCollectionView.dataSource = self.hourlyHelper
        let nib = UINib(nibName: "HourlyCollectionViewCell", bundle: Bundle.main)
        self.hourlyCollectionView.register(nib, forCellWithReuseIdentifier: "hour")
        let headerNib = UINib(nibName: "HourHeaderView", bundle: Bundle.main)
        self.hourlyCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "hourheader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("got to view will appear")
        weatherFetcher(locationService: locationService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
                if let weather = result.successValue() {
                    self?.weather = weather
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineHeightMultiple = 1.1
                    let description = NSAttributedString(string: weather.fullSummary, attributes:
                        [NSFontAttributeName:UIFont(name:"FiraSans-Book", size:18.0)!,
                         NSParagraphStyleAttributeName:paragraphStyle])
                    self?.weatherDescription.attributedText = description
                    self?.hourlyHelper.weather = weather
                    self?.locationName.text = weather.location.name

                    self?.hourlyCollectionView.reloadData()
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
        self.weatherDescription.text = nil
        self.view.layoutSubviews()
        self.animator.removeAllBehaviors()
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
            self.hourlyCollectionView.isHidden = false
        default:
            self.hourlyCollectionView.isHidden = true
            self.dailyCollectionView.isHidden = false
        }
    }
}

extension WeatherViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        self.hourlyCollectionView.isHidden = false
        self.toggleSwitch.isHidden = false
        print("pausing")
        self.headerBackgroundTopConstraint.constant = 0
    }
}
