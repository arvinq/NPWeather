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
    
    var suburbNameLabel: TitleLabel!
    var suburbConditionLabel: SecondaryTitleLabel!
    var suburbTemperatureLabel: TemperatureLabel!
    
    var textStackView: UIStackView!
    var separatorView: UIView!
    
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
        separatorView = UIView()
        separatorView.backgroundColor = .systemGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        
        textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fillProportionally
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textStackView)
        
        suburbNameLabel = TitleLabel(fontSize: contentView.bounds.height * 0.2)
        textStackView.addArrangedSubview(suburbNameLabel)
        
        suburbConditionLabel = SecondaryTitleLabel(fontSize: contentView.bounds.height * 0.15)
        textStackView.addArrangedSubview(suburbConditionLabel)
        
        suburbTemperatureLabel = TemperatureLabel(fontSize: contentView.bounds.height * 0.4)
        addSubview(suburbTemperatureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
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
