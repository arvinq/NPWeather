//
//  ViewModelManager.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import Foundation

class ViewModelManager {
    
    //single instance manager
    static let shared = ViewModelManager()
    private init() { }
    
    private var suburbViewModelList: [SuburbViewModel]   = []
    private var countryViewModelList: [CountryViewModel] = []
    
    private var filteredSuburbList: [SuburbViewModel] = []
    var countryFiltered: CountryViewModel?
    
    var sortDescriptor: SortDescriptor = .alphabetically {
        didSet {
            sortFilteredSuburb()
        }
    }
    
    var countryListCount: Int {
        return countryViewModelList.count
    }
    
    func retrieveSuburbs(completion: @escaping (NPError?) -> Void) {
        NetworkManager.shared.getSuburbs { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let suburbs):
                    self.suburbViewModelList  = suburbs.map { SuburbViewModel(suburb: $0) }
                    self.filteredSuburbList = self.suburbViewModelList
                    
                    var tempCountryList       = [CountryViewModel(name: "All")]
                    tempCountryList.append(contentsOf: suburbs.map { CountryViewModel(name: $0.country.name) })
                    self.countryViewModelList = tempCountryList.uniqueElements
                    
                    completion(nil)
                case .failure(let error):
                    completion(error)
            }
        }
    }
    
    func getSuburbList() -> [SuburbViewModel] {
        return suburbViewModelList
    }
    
    func getCountryList() -> [CountryViewModel] {
        return countryViewModelList
    }
    
    func country(at index: Int) -> CountryViewModel {
        return countryViewModelList[index]
    }
    
    func getFilteredSuburbList() -> [SuburbViewModel] {
        return filteredSuburbList
    }
    
    func setFilteredSuburb(for country: CountryViewModel) {
        countryFiltered = country
        
        guard country.name != "All" else {
            filteredSuburbList = self.suburbViewModelList
            sortFilteredSuburb()
            return
        }
        
        filteredSuburbList = suburbViewModelList.filter { $0.country == country.name }
        sortFilteredSuburb()
    }
    
    var filteredSuburbCount: Int {
        return filteredSuburbList.count
    }
    
    func sortFilteredSuburb() {
        switch sortDescriptor {
            case .alphabetically: filteredSuburbList.sort { $0.suburbName < $1.suburbName }
            case .temperature: filteredSuburbList.sort { $0.weatherTemp! < $1.weatherTemp! }
            case .lastUpdate: filteredSuburbList.sort { $0.lastUpdated! > $1.lastUpdated! }
        }
    }
}
