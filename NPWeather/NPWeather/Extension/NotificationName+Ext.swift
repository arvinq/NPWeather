//
//  NotificationName+Ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/5/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

/**
 * Custom notification used when applying a filter / sort on our suburb list
 */
extension Notification.Name {
    static let NPWeatherApplyFilterSort = NSNotification.Name("applyFilterSort")
}
