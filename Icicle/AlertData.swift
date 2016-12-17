//
//  AlertData.swift
//  Icicle
//
//  Created by Kevin McGladdery on 12/16/16.
//  Copyright © 2016 Kevin McGladdery. All rights reserved.
//

import Foundation

struct AlertData {
    let title: String
    let description: String
    let expires: String
    let url: URL?
    
    static let timeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "M/d • h:mm vvvv"
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    static func create(_ alert:Alert) -> AlertData {
        let title = alert.title
        let description = alert.description
        let expires = timeformatter.string(from: Date(timeIntervalSince1970: alert.expires))
        let url = URL(string: alert.uri)
        
        return AlertData(title: title, description: description, expires: expires, url: url)
    }
}
