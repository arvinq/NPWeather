//
//  Sport.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

struct Sport: Codable {
    let sportId: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case sportId = "_sportID"
        case description = "_description"
    }
}
