//
//  Double+Ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

extension Double {
    
    /**
     * Computed property to convert timestamp to string date.
     */
    var toStringDate: String {
        get {
            let date = Date(timeIntervalSince1970: self)
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "AEST")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "h:mm a, dd MMMM yyyy"
            
            return dateFormatter.string(from: date)
        }
    }
}
