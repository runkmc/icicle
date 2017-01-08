//
//  WeatherFetcher.swift
//  Icicle
//
//  Created by Kevin McGladdery on 10/19/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

func weatherFetcher(locationService:LocationService, session:DataTask, key:String, completion:@escaping (Result<WeatherError, WeatherData>) -> ()) {
    locationService.getLocation { location in
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        let urlString = "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)"
        let weatherUrl = URL(string:urlString)
        guard let url = weatherUrl else {
            let errorString = "Problem creating url string: \(urlString)"
            NSLog(errorString)
            completion(.error(.urlError(errorString)))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let err = error {
                NSLog(err.localizedDescription)
                completion(.error(.httpError("I found an error instead of the weather. Sorry about that.")))
                return
            }
            
            guard let downloadedData = data else {
                NSLog("No data found")
                completion(.error(.missingData))
                return
            }
            
            let decodedData = decoder(data: downloadedData)
            guard let models = decodedData.successValue() else {
                let message = decodedData.errorValue()?.first ?? "Error decoding data"
                NSLog(message)
                completion(.error(.decodingError(message)))
                return
            }
            
            let formattedModels = WeatherData.create(models: models)
            guard let viewModels = formattedModels.successValue() else {
                NSLog(formattedModels.errorValue()!)
                completion(.error(.formattingError(formattedModels.errorValue()!)))
                return
            }
            
            completion(.success(viewModels))
        }.resume()
    }
}
