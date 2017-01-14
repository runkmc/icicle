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
    var locationService: LocationService = CurrentLocationService.instance
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var headerBackground: UIView!
    @IBOutlet weak var headerBackgroundTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    var weather: WeatherData? = nil
    let animator = UIDynamicAnimator()
    let layout:UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        l.itemSize = CGSize(width: 200, height: 300)
        l.scrollDirection = .horizontal
        l.headerReferenceSize = CGSize(width: 120, height: 300)
        l.sectionHeadersPinToVisibleBounds = true
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false
        self.hourlyCollectionView.collectionViewLayout = self.layout
        self.hourlyCollectionView.delegate = self
        self.hourlyCollectionView.dataSource = self
        let nib = UINib(nibName: "HourlyCollectionViewCell", bundle: Bundle.main)
        self.hourlyCollectionView.register(nib, forCellWithReuseIdentifier: "hour")
        let headerNib = UINib(nibName: "HourHeaderView", bundle: Bundle.main)
        self.hourlyCollectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("got to view will appear")
        weatherFetcher(locationService: locationService, session: URLSession.shared, key: forecastAPIKEY) { [weak self] result in
            DispatchQueue.main.sync {
                print("block ran")
                if let weather = result.successValue() {
                    self?.weather = weather
                    self?.locationName.text = weather.location.name
                    self?.weatherDescription.text = weather.fullSummary
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
        // Dispose of any resources that can be recreated.
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weather?.hours.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hour", for: indexPath) as! HourlyCollectionViewCell
        cell.display(self.weather!.hours[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        return header
    }
}

extension WeatherViewController: UICollectionViewDelegate { }

extension WeatherViewController: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        self.headerBackgroundTopConstraint.constant = 0
    }
}
