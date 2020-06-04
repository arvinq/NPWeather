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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    }
    
    private func setupConstraints() {
        
    }
    
    @objc private func exitPressed() {
        dismiss(animated: true)
    }
}
