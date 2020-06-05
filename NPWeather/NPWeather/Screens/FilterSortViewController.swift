//
//  FilterSortViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class FilterSortViewController: UIViewController {

    //MARK: - Property Declaration
    
    var exitBarButtonItem: UIBarButtonItem!
    
    // sort group
    var sortLabel: TitleLabel!
    var sortStackView: UIStackView!
    var alphabeticallyLabel: SecondaryTitleLabel!
    var temperatureLabel: SecondaryTitleLabel!
    var lastUpdatedLabel: SecondaryTitleLabel!
    
    // filter group
    var filterLabel: TitleLabel!
    var filterCountryLabel: SecondaryTitleLabel!
    var filterCountryValueLabel: SecondaryTitleLabel!
    var filterPickerView: UIPickerView!

    var lowerSeparatorConstraint: NSLayoutConstraint!
    var isPickerViewVisible: Bool = false {
        willSet {
            //toggling picker view also toggles the separator's constraint
            self.lowerSeparatorConstraint.constant = newValue ? Space.largerInset + self.filterPickerView.bounds.height : Space.inset
        }
    }
    
    //separator and button
    var separatorUpperView: UIView!
    var separatorLowerView: UIView!
    var applyButton: UIButton!
    
    enum Space {
        //local enum for some magic numbers used within the class
        static let inset           = CGFloat(20)
        static let largerInset     = CGFloat(30)
        static let separatorHeight = CGFloat(0.5)
    }
    
    //MARK: - View Hierarchy Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAfterLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPickerValue()
    }
    
    //MARK: - Setup views
    
    private func setup() {
        setupView()
        setupConstraints()
        setupGestureRecognizer()
    }
    
    private func setupView() {
        // configure navigation bar
        view.backgroundColor = .systemBackground
        title = NavTitle.filterSort
        
        exitBarButtonItem = UIBarButtonItem(image: SFSymbols.close, style: .done, target: self, action: #selector(exitPressed))
        navigationItem.setRightBarButton(exitBarButtonItem, animated: true)
        
        // sort caption
        sortLabel = TitleLabel(fontSize: view.bounds.height * 0.03, text: "Sort")
        view.addSubview(sortLabel)
        
        // sort descriptor container
        sortStackView = UIStackView()
        sortStackView.axis = .vertical
        sortStackView.alignment = .fill
        sortStackView.distribution = .fillProportionally
        sortStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sortStackView)
        
        // customized label corresponding to each sort descriptor
        alphabeticallyLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        alphabeticallyLabel.setImageAndText(usingImage: SFSymbols.alphabet!, andText: "Alphabetically")
        sortStackView.addArrangedSubview(alphabeticallyLabel)
        
        temperatureLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        temperatureLabel.setImageAndText(usingImage: SFSymbols.thermometer!, andText: "Temperature")
        sortStackView.addArrangedSubview(temperatureLabel)
        
        lastUpdatedLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        lastUpdatedLabel.setImageAndText(usingImage: SFSymbols.calendar!, andText: "Last Updated")
        sortStackView.addArrangedSubview(lastUpdatedLabel)

        // filter caption
        filterLabel = TitleLabel(fontSize: view.bounds.height * 0.03, text: "Filter")
        view.addSubview(filterLabel)
        
        filterCountryLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .secondaryLabel)
        filterCountryLabel.text = "Country:"
        view.addSubview(filterCountryLabel)
        
        filterCountryValueLabel = SecondaryTitleLabel(fontSize: view.bounds.height * 0.03, fontColor: .systemTeal)
        view.addSubview(filterCountryValueLabel)
        
        // counter picker selection
        filterPickerView = UIPickerView()
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterPickerView)
        
        applyButton = UIButton()
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .systemGray
        applyButton.addTarget(self, action: #selector(applyPressed), for: .touchUpInside)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyButton)
        
        //separator views
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
        NSLayoutConstraint.activate([
            //sort caption
            sortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.inset),
            sortLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Space.inset),
            
            //sort descriptor container
            sortStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            sortStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            sortStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sortStackView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: Space.inset),

            //first separator view
            separatorUpperView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorUpperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorUpperView.heightAnchor.constraint(equalToConstant: Space.separatorHeight),
            separatorUpperView.topAnchor.constraint(equalTo: sortStackView.bottomAnchor, constant: Space.inset),

            //filter caption
            filterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.inset),
            filterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterLabel.topAnchor.constraint(equalTo: separatorUpperView.bottomAnchor, constant: Space.inset),
            
            //filter picker and country label
            filterCountryLabel.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: Space.inset),
            filterCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.inset * 2),
            
            filterCountryValueLabel.centerYAnchor.constraint(equalTo: filterCountryLabel.centerYAnchor),
            filterCountryValueLabel.leadingAnchor.constraint(equalTo: filterCountryLabel.trailingAnchor, constant: Space.inset),
            
            filterPickerView.widthAnchor.constraint(equalTo: sortStackView.widthAnchor, multiplier: 0.7),
            filterPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            filterPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterPickerView.topAnchor.constraint(equalTo: filterCountryLabel.bottomAnchor, constant: Space.inset),
            
            //second separator view
            separatorLowerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            separatorLowerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorLowerView.heightAnchor.constraint(equalToConstant: Space.separatorHeight),
            
            //action button
            applyButton.topAnchor.constraint(equalTo: separatorLowerView.bottomAnchor, constant: Space.inset - 10),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.widthAnchor.constraint(equalTo: sortStackView.widthAnchor, multiplier: 0.8),
            applyButton.heightAnchor.constraint(equalTo: sortStackView.heightAnchor, multiplier: 0.3),
        ])
        
        lowerSeparatorConstraint = separatorLowerView.topAnchor.constraint(equalTo: filterCountryLabel.bottomAnchor, constant: Space.inset)
        lowerSeparatorConstraint.isActive = true
    }
    
    private func setupAfterLayout() {
        // rounds button corner after it has been layed out
        applyButton.layer.cornerRadius = applyButton.frame.size.height / 5
    }
    
    /**
     * Checks if a filter has been preformed recently, if it has, get the index of the filtered country in countryViewModel List and
     * pre-select the row in picker view.
     */
    private func setupPickerValue() {
        guard let selectedCountry = ViewModelManager.shared.countryFiltered else { return }
        
        let countryList = ViewModelManager.shared.getCountryList()
        filterPickerView.selectRow(countryList.firstIndex(of: selectedCountry) ?? 0, inComponent: 0, animated: false)
        filterCountryValueLabel.text = selectedCountry.name
    }
    
    /**
     * Sets up the gesture recognizer for the sort labels. Each of the sorting labels correspond to a sort descriptor
     */
    private func setupGestureRecognizer() {
        let alphabeticalTapGesture = SorterTapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        alphabeticalTapGesture.sortDesc = .alphabetically
        
        let temperatureTapGesture = SorterTapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        temperatureTapGesture.sortDesc = .temperature
        
        let lastUpdateTapGesture = SorterTapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        lastUpdateTapGesture.sortDesc = .lastUpdate
        
        alphabeticallyLabel.addGestureRecognizer(alphabeticalTapGesture)
        temperatureLabel.addGestureRecognizer(temperatureTapGesture)
        lastUpdatedLabel.addGestureRecognizer(lastUpdateTapGesture)
        
        filterCountryValueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(filterLabelTapped)))
    }
    
    //MARK: - Controller methods
    
    @objc private func exitPressed() {
        dismiss(animated: true)
    }
    
    /// Post the changes made to ViewModel filter list
    @objc private func applyPressed() {
        dismiss(animated: true) {
            NotificationCenter.default.post(.init(name: .NPWeatherApplyFilterSort))
        }
    }
    
    @objc private func labelTapped(_ sender: SorterTapGestureRecognizer) {
        // reset back all of the sorting label's text color
        [alphabeticallyLabel, temperatureLabel, lastUpdatedLabel].forEach {
            $0?.textColor = .secondaryLabel
        }
        
        // after resetting back the colors, apply a different color on the selected sort label
        guard let selectedLabel = sender.view as? UILabel else { return }
        selectedLabel.textColor = .systemTeal
        
        // assign the sort descriptor tied in the tapGesture to ViewModelManager's sortDescriptor property
        ViewModelManager.shared.sortDescriptor = sender.sortDesc!
    }
    
    /// action to animate picker visibility and lower separator's constraint
    @objc private func filterLabelTapped() {
        UIView.animate(withDuration: 0.35, animations: {
            self.isPickerViewVisible.toggle()
            self.view.layoutIfNeeded()
        }) { (true) in
            self.filterPickerView.isHidden = !self.isPickerViewVisible
        }
    }
}

//MARK: - Picker Delegate & DataSource methods

extension FilterSortViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ViewModelManager.shared.countryListCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(ViewModelManager.shared.country(at: row).name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = ViewModelManager.shared.country(at: row)
        filterCountryValueLabel.text = selectedCountry.name
        ViewModelManager.shared.setFilteredSuburb(for: selectedCountry)
    }
}
