//
//  FilterSortViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class FilterSortViewController: UIViewController {

    var exitBarButtonItem: UIBarButtonItem!
    
    var sortLabel: TitleLabel!
    var sortStackView: UIStackView!
    var alphabeticallyLabel: SecondaryTitleLabel!
    var temperatureLabel: SecondaryTitleLabel!
    var lastUpdatedLabel: SecondaryTitleLabel!
    
    var filterLabel: TitleLabel!
    var filterCountryLabel: SecondaryTitleLabel!
    var filterPickerView: UIPickerView!
    
    var separatorUpperView: UIView!
    var separatorLowerView: UIView!
    var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAfterLayout()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = NavTitle.filterSort
        
        exitBarButtonItem = UIBarButtonItem(image: SFSymbols.close, style: .done, target: self, action: #selector(exitPressed))
        navigationItem.setRightBarButton(exitBarButtonItem, animated: true)
        
        sortLabel = TitleLabel(fontSize: view.bounds.height * 0.03, text: "Sort")
        view.addSubview(sortLabel)
        
        sortStackView = UIStackView()
        sortStackView.axis = .vertical
        sortStackView.alignment = .fill
        sortStackView.distribution = .fillProportionally
        sortStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sortStackView)
        
        alphabeticallyLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        alphabeticallyLabel.setImageAndText(usingImage: SFSymbols.alphabet!, andText: "Alphabetically")
        sortStackView.addArrangedSubview(alphabeticallyLabel)
        
        temperatureLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        temperatureLabel.setImageAndText(usingImage: SFSymbols.thermometer!, andText: "Temperature")
        sortStackView.addArrangedSubview(temperatureLabel)
        
        lastUpdatedLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        lastUpdatedLabel.setImageAndText(usingImage: SFSymbols.calendar!, andText: "Last Updated")
        sortStackView.addArrangedSubview(lastUpdatedLabel)

        filterLabel = TitleLabel(fontSize: view.bounds.height * 0.03, text: "Filter")
        view.addSubview(filterLabel)
        
        filterCountryLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        filterCountryLabel.text = "Country:"
        view.addSubview(filterCountryLabel)
        
        filterPickerView = UIPickerView()
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterPickerView)
        
        applyButton = UIButton()
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .systemGray
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyButton)
        
        separatorUpperView = UIView()
        separatorUpperView.backgroundColor = .systemGray
        separatorUpperView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorUpperView)
        
        separatorLowerView = UIView()
        separatorLowerView.backgroundColor = .systemGray
        separatorLowerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLowerView)
    }
    
    private func setupConstraints() {
        let inset           = CGFloat(20)
        let separatorHeight = CGFloat(0.5)
        
        NSLayoutConstraint.activate([
            sortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            sortLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            
            sortStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            sortStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            sortStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sortStackView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: inset),

            separatorUpperView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorUpperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorUpperView.heightAnchor.constraint(equalToConstant: separatorHeight),
            separatorUpperView.topAnchor.constraint(equalTo: sortStackView.bottomAnchor, constant: inset),

            filterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            filterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterLabel.topAnchor.constraint(equalTo: separatorUpperView.bottomAnchor, constant: inset),
            
            filterCountryLabel.centerYAnchor.constraint(equalTo: filterPickerView.centerYAnchor),
            filterCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset * 2),
            
            filterPickerView.widthAnchor.constraint(equalTo: sortStackView.widthAnchor, multiplier: 0.4),
            filterPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            filterPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            filterPickerView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor),
            
            separatorLowerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorLowerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLowerView.heightAnchor.constraint(equalToConstant: separatorHeight),
            separatorLowerView.topAnchor.constraint(equalTo: filterPickerView.bottomAnchor, constant: inset),
            
            applyButton.topAnchor.constraint(equalTo: separatorLowerView.bottomAnchor, constant: inset * 2),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            applyButton.heightAnchor.constraint(equalTo: sortStackView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    private func setupAfterLayout() {
        applyButton.layer.cornerRadius = applyButton.frame.size.height / 5
    }
    
    @objc private func exitPressed() {
        dismiss(animated: true)
    }
}

extension FilterSortViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
}
