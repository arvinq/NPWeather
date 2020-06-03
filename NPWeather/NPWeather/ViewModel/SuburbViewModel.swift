//
//  SuburbViewModel.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct SuburbViewModel: Hashable {
    var suburbId: Int
    var suburbName: String
    var weatherCondition: String?
    var weatherTemp: Int?
    var weatherFeelsLike: Int?
    var weatherHumidity: String?
    var weatherWind: String?
    var weatherLastUpdated: String?

    init(id: Int, suburbName: String, weatherCondition: String? = nil, weatherTemp: String? = nil, weatherFeelsLike: String? = nil, weatherHumidity: String? = nil, weatherWind: String? = nil, weatherLastUpdated: Int? = nil) {
        self.suburbId           = id
        self.suburbName         = suburbName
        self.weatherCondition   = weatherCondition
        self.weatherTemp        = Int(weatherTemp ?? "") ?? 0
        self.weatherFeelsLike   = Int(weatherFeelsLike ?? "") ?? 0
        self.weatherHumidity    = weatherHumidity
        self.weatherWind        = weatherWind
        self.weatherLastUpdated = Double(weatherLastUpdated ?? 0).toStringDate
    }
    
    init(suburb: Suburb) {
        self.init(id: Int(suburb.venueId)!, suburbName: suburb.name, weatherCondition: suburb.weatherCondition, weatherTemp: suburb.weatherTemp, weatherFeelsLike: suburb.weatherFeelsLike, weatherHumidity: suburb.weatherHumidity, weatherWind: suburb.weatherWind, weatherLastUpdated: suburb.weatherLastUpdated)
    }
}
