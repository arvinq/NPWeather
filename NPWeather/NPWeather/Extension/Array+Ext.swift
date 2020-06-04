//
//  Array+Ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/5/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var uniqueElements: [Element] {
        var setElements = Set(self)
        return compactMap { setElements.remove($0) }
    }
}
