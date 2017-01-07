//
//  URLSession.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/6/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import Foundation

extension URLSession: DataTask {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskResumable {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask)
    }
}
