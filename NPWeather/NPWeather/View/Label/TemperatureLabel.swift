//
//  TemperatureLabel.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class TemperatureLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        textColor                   = .systemTeal
        adjustsFontSizeToFitWidth   = true
        lineBreakMode               = .byTruncatingTail
        minimumScaleFactor          = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
