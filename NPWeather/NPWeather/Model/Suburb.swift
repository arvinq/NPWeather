//
//  Suburb.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct Suburb: Codable {
    let venueId: String
    let name: String
    let country: Country
    let sport: Sport
    let weatherCondition: String?
    let weatherConditionIcon: String?
    let weatherWind: String?
    let weatherHumidity: String?
    let weatherTemp: String?
    let weatherFeelsLike: String?
    let weatherLastUpdated: Int?
    
    enum CodingKeys: String, CodingKey {
        case venueId = "_venueID"
        case name = "_name"
        case country = "_country"
        case sport = "_sport"
        case weatherCondition = "_weatherCondition"
        case weatherConditionIcon = "_weatherConditionIcon"
        case weatherWind = "_weatherWind"
        case weatherHumidity = "_weatherHumidity"
        case weatherTemp = "_weatherTemp"
        case weatherFeelsLike = "_weatherFeelsLike"
        case weatherLastUpdated = "_weatherLastUpdated"
    }
}

/** Intermediary Structure */
struct Suburbs: Codable {
    let data: [Suburb]
}
