//
//  SuburbCollectionViewCell.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class SuburbCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "SuburbCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemPink
    }
    
    private func setupConstraints() {
        
    }
    
}
