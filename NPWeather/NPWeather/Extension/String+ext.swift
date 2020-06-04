//
//  String+ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

extension String {
    var degree: String {
        return "\(self)\u{00B0}"
    }
    
    // We're getting the upperBound from our starting text so that we'll know
    // what index to start from to get our desired value
    // https://stackoverflow.com/a/56128734
    func getSubstring(after startText: String) -> String {
        guard let startIndex = range(of: startText)?.upperBound else { return "" }
        return "\(self[startIndex...])"
    }
}
