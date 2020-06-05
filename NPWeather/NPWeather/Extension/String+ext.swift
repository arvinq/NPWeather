//
//  String+ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

extension String {
    
    /// Adds a degree symbol when used by string
    var degree: String {
        return "\(self)\u{00B0}"
    }
    
    /**
     * We're getting the upperBound from our starting text so that we'll know
     * what index to start from to get our desired value
     *
     * - Parameters:
     *   - startText: substring from where to start our range
     */
    func getSubstring(after startText: String) -> String {
        guard let startIndex = range(of: startText)?.upperBound else { return "" }
        return "\(self[startIndex...])"
    }
}
