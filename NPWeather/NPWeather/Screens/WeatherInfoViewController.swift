//
//  WeatherInfoViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class WeatherInfoViewController: UIViewController {

    var doneBarButton: UIBarButtonItem!
    
    var suburbGeneralInfoView: UIView!
    var suburbAdditionalInfoView: UIView!
    var lastUpdateLabel: SecondaryTitleLabel!
    
    var separatorViewUpper: UIView!
    var separatorViewLower: UIView!
    
    var suburbViewModel: SuburbViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
        setupSuburbInfo()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Weather"
        
        doneBarButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backPressed))
        navigationItem.setLeftBarButton(doneBarButton, animated: true)
        
        suburbGeneralInfoView = UIView()
        suburbGeneralInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(suburbGeneralInfoView)
        
        suburbAdditionalInfoView = UIView()
        suburbAdditionalInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(suburbAdditionalInfoView)
        
        lastUpdateLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.02)
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastUpdateLabel)
        
        separatorViewUpper = UIView()
        separatorViewUpper.backgroundColor = .systemGray
        separatorViewUpper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorViewUpper)
        
        separatorViewLower = UIView()
        separatorViewLower.backgroundColor = .systemGray
        separatorViewLower.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorViewLower)
    }
    
    private func setupConstraints() {
        let inset           = CGFloat(20)
        let separatorHeight = CGFloat(0.5)
        
        NSLayoutConstraint.activate([
            suburbGeneralInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            suburbGeneralInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            suburbGeneralInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            suburbGeneralInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            
            separatorViewUpper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorViewUpper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorViewUpper.heightAnchor.constraint(equalToConstant: separatorHeight),
            separatorViewUpper.topAnchor.constraint(equalTo: suburbGeneralInfoView.bottomAnchor, constant: inset),
            
            suburbAdditionalInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            suburbAdditionalInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            suburbAdditionalInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            suburbAdditionalInfoView.topAnchor.constraint(equalTo: separatorViewUpper.bottomAnchor, constant: inset),
            
            separatorViewLower.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorViewLower.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorViewLower.heightAnchor.constraint(equalToConstant: separatorHeight),
            separatorViewLower.topAnchor.constraint(equalTo: suburbAdditionalInfoView.bottomAnchor, constant: inset),
            
            lastUpdateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastUpdateLabel.topAnchor.constraint(equalTo: separatorViewLower.bottomAnchor, constant: inset)
        ])
    }
    
    private func setupSuburbInfo() {
        self.add(childViewController: GeneralInfoViewController(suburbViewModel: suburbViewModel!), to: self.suburbGeneralInfoView)
        self.add(childViewController: AdditionalInfoViewController(suburbViewModel: suburbViewModel!), to: self.suburbAdditionalInfoView)
        lastUpdateLabel.text = suburbViewModel?.weatherLastUpdated
    }
    
    @objc private func backPressed() {
        dismiss(animated: true)
    }

}
