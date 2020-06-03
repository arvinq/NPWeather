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
    
    var suburbNameLabel: UILabel!
    var suburbConditionLabel: UILabel!
    var suburbTemperatureLabel: UILabel!
    
    var textStackView: UIStackView!
    
    var suburbViewModel: SuburbViewModel? {
        didSet {
            bindValues()
        }
    }
    
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
        
        textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fillProportionally
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textStackView)
        
        suburbNameLabel = UILabel()
        suburbNameLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(suburbNameLabel)
        
        suburbConditionLabel = UILabel()
        suburbConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        textStackView.addArrangedSubview(suburbConditionLabel)
        
        suburbTemperatureLabel = UILabel()
        suburbTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(suburbTemperatureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textStackView.topAnchor.constraint(equalTo: topAnchor),
            textStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            suburbTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            suburbTemperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            suburbTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bindValues() {
        suburbNameLabel.text = suburbViewModel?.suburbName
        suburbConditionLabel.text = suburbViewModel?.weatherCondition ?? "Clear"
        suburbTemperatureLabel.text = String(suburbViewModel?.weatherTemp ?? 0).degree
    }
    
}
