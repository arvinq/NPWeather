//
//  Suburb.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct Suburb: Codable {
    let venueID: Int
    let name: String
    let country: Country
    let sport: Sport
    let weatherCondition: String?
    let weatherConditionIcon: String?
    let weatherWind: String?
    let weatherHumidity: String?
    let weatherTemp: Int?
    let weatherFeelsLike: Int?
    let weatherLastUpdated: Date?
}

/** Intermediary Structure */
struct Data: Codable {
    let data: [Suburb]
}
