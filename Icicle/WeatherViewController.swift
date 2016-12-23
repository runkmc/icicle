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
    let location: Location? = nil
    let weatherData: WeatherData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let givenLocation = location {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
