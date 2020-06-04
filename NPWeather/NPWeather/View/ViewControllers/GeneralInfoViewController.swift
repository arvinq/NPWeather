//
//  GeneralInfoViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class GeneralInfoViewController: UIViewController {

    var suburbViewModel: SuburbViewModel?
    var suburbNameLabel: TitleLabel!
    var suburbConditionLabel: SecondaryTitleLabel!
    var suburbTemperatureLabel: TemperatureLabel!
    
    var generalInfoStackView: UIStackView!
    
    init(suburbViewModel: SuburbViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.suburbViewModel = suburbViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupViews()
        setupConstraints()
        bindValues()
    }
    
    private func setupViews() {
        generalInfoStackView = UIStackView()
        generalInfoStackView.distribution = .equalSpacing
        generalInfoStackView.axis = .vertical
        generalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(generalInfoStackView)
        
        suburbNameLabel = TitleLabel(fontSize: view.bounds.height * 0.03)
        generalInfoStackView.addArrangedSubview(suburbNameLabel)
        
        suburbConditionLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03)
        generalInfoStackView.addArrangedSubview(suburbConditionLabel)
        
        suburbTemperatureLabel = TemperatureLabel(fontSize: view.bounds.height * 0.08)
        view.addSubview(suburbTemperatureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            generalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalInfoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            generalInfoStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            suburbTemperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suburbTemperatureLabel.topAnchor.constraint(equalTo: view.topAnchor),
            suburbTemperatureLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindValues() {
        suburbNameLabel.text = suburbViewModel?.suburbName
        suburbConditionLabel.text = suburbViewModel?.weatherCondition ?? "Clear"
        suburbTemperatureLabel.text = String(suburbViewModel?.weatherTemp ?? 0).degree
    }
}
