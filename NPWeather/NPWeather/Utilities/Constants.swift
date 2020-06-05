//
//  Constants.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

/// Used images throughout the application
enum SFSymbols {
    static let filterSort   = UIImage(systemName: "line.horizontal.3.decrease.circle")
    static let filterSort2  = UIImage(systemName: "arrow.up.arrow.down")
    static let close        = UIImage(systemName: "xmark")
    static let calendar     = UIImage(systemName: "calendar")
    static let alphabet     = UIImage(systemName: "textformat.abc")
    static let thermometer  = UIImage(systemName: "thermometer")
}

/// Navigation item titles
enum NavTitle {
    static let filterSort = "Filter | Sort"
    static let weather    = "Weather"
}

/// Determines the sort to use as selected in sort page
enum SortDescriptor {
    case alphabetically, temperature, lastUpdate
}
