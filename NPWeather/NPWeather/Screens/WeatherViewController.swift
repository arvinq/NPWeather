//
//  WeatherViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/2/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        
        //setup navigation bar
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupConstraints() {
        
    }

}

