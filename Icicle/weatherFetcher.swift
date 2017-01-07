//
//  WeatherFetcher.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func weatherFetcher(locationService:LocationService, session:DataTask, key:String, completion:@escaping (Result<[String], WeatherData>) -> ()) {
    var errors:[String] = []
    locationService.getLocation { location in
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        let urlString = "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)"
        let weatherUrl = URL(string:urlString)
        guard let url = weatherUrl else {
            let errorString = "Problem creating url string: \(urlString)"
            NSLog(errorString)
            errors.append(errorString)
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let err = error {
                errors.append(err.localizedDescription)
                NSLog(err.localizedDescription)
                completion(.error(errors))
                return
            }
            
            guard let downloadedData = data else { errors.append("No data found"); return }
            let decodedData = decoder(data: downloadedData)
            guard let models = decodedData.successValue() else { errors.append(contentsOf: decodedData.errorValue()!); return }
            
            let formattedModels = WeatherData.create(models: models)
            guard let viewModels = formattedModels.successValue() else { errors.append(formattedModels.errorValue()!); return }
            
            completion(.success(viewModels))
        }.resume()
    }
    
    if errors.count > 0 {
        completion(.error(errors))
    }
}
