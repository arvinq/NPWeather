//
//  SuburbCollectionViewCell.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class SuburbCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property Declaration
    
    //reuse identifier
    static let reuseId = "SuburbCollectionViewCell"
    
    //main property for values
    var suburbNameLabel: TitleLabel!
    var suburbConditionLabel: SecondaryTitleLabel!
    var suburbTemperatureLabel: TemperatureLabel!
    
    //additional view and container
    var textStackView: UIStackView!
    var separatorView: UIView!
    
    //data source
    var suburbViewModel: SuburbViewModel? {
        didSet {
            bindValues()
        }
    }
    
    //MARK: - Initial Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        //separate infos
        separatorView = UIView()
        separatorView.backgroundColor = .systemGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        
        //container
        textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fillProportionally
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textStackView)
        
        //suburb info
        suburbNameLabel = TitleLabel(fontSize: contentView.bounds.height * 0.2)
        textStackView.addArrangedSubview(suburbNameLabel)
        
        suburbConditionLabel = SecondaryTitleLabel(fontSize: contentView.bounds.height * 0.15)
        textStackView.addArrangedSubview(suburbConditionLabel)
        
        suburbTemperatureLabel = TemperatureLabel(fontSize: contentView.bounds.height * 0.4)
        addSubview(suburbTemperatureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //separator
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            //other info container
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            //temperature label
            suburbTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            suburbTemperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            suburbTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Bind values
    
    private func bindValues() {
        suburbNameLabel.text = suburbViewModel?.suburbName
        suburbConditionLabel.text = suburbViewModel?.weatherCondition ?? "Clear"
        suburbTemperatureLabel.text = String(suburbViewModel?.weatherTemp ?? 0).degree
    }
    
}
