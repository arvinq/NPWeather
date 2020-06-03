//
//  Country.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct Country: Codable {
    let countryId: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case countryId = "_countryID"
        case name = "_name"
    }
}
