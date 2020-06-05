//
//  AdditionalInfoViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class AdditionalInfoViewController: UIViewController {

    //MARK: - Property Declaration
    
    //data source
    var suburbViewModel: SuburbViewModel?
    
    //additional info labels
    var feelsLikeLabel: TitleLabel!
    var humidityLabel: TitleLabel!
    var windLabel: TitleLabel!
    
    //additional info values
    var feelsLikeValueLabel: SecondaryTitleLabel!
    var humidityValueLabel: SecondaryTitleLabel!
    var windValueLabel: SecondaryTitleLabel!
    
    //view containers
    var additionalInfoStackView: UIStackView!
    var feelsLikeStackView: UIStackView!
    var humidityStackView: UIStackView!
    var windStackView: UIStackView!
    
    //MARK: - Initial Methods
    
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
    
    //MARK: - Setup views
    
    private func setup() {
        setupView()
        setupConstraints()
        bindValues()
    }
    
    private func setupView() {
        //magic numbers
        let fontSizeLabel       = view.bounds.height * 0.025
        let fontSizeValueLabel  = view.bounds.height * 0.02
       
        //whole additional info container
        additionalInfoStackView = UIStackView()
        additionalInfoStackView.distribution = .equalSpacing
        additionalInfoStackView.axis = .horizontal
        additionalInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(additionalInfoStackView)
        
        //feelsLike container
        feelsLikeStackView = UIStackView()
        feelsLikeStackView.distribution = .equalSpacing
        feelsLikeStackView.axis = .vertical
        additionalInfoStackView.addArrangedSubview(feelsLikeStackView)
        
        //humidity container
        humidityStackView = UIStackView()
        humidityStackView.distribution = .equalSpacing
        humidityStackView.axis = .vertical
        additionalInfoStackView.addArrangedSubview(humidityStackView)
        
        //wind info container
        windStackView = UIStackView()
        windStackView.distribution = .equalSpacing
        windStackView.axis = .vertical
        additionalInfoStackView.addArrangedSubview(windStackView)
                
        //feels like label and value
        feelsLikeLabel      = TitleLabel(fontSize: fontSizeLabel, text: "Feels Like")
        feelsLikeValueLabel = SecondaryTitleLabel(fontSize: fontSizeValueLabel, fontColor: .systemTeal)
        feelsLikeStackView.addArrangedSubview(feelsLikeLabel)
        feelsLikeStackView.addArrangedSubview(feelsLikeValueLabel)
        
        //humidity label and value
        humidityLabel      = TitleLabel(fontSize: fontSizeLabel, text: "Humidity")
        humidityValueLabel = SecondaryTitleLabel(fontSize: fontSizeValueLabel, fontColor: .systemTeal)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        
        //wind info label and value
        windLabel = TitleLabel(fontSize: fontSizeLabel, text: "Wind")
        windValueLabel = SecondaryTitleLabel(fontSize: fontSizeValueLabel, fontColor: .systemTeal)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windValueLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            additionalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            additionalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            additionalInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additionalInfoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            additionalInfoStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }
    
    //MARK: - Bind values
    
    private func bindValues() {
        feelsLikeValueLabel.text = String(suburbViewModel?.weatherFeelsLike ?? 0).degree
        humidityValueLabel.text = suburbViewModel?.weatherHumidity?.getSubstring(after: "Humidity: ") ?? "N/A"
        windValueLabel.text = suburbViewModel?.weatherWind?.getSubstring(after: "Wind: ") ?? "N/A"
    }
}
