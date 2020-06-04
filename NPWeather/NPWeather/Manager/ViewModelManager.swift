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
    
    var countryListCount: Int {
        return countryViewModelList.count
    }
    
    func retrieveSuburbs(completion: @escaping (NPError?) -> Void) {
        NetworkManager.shared.getSuburbs { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let suburbs):
                    self.suburbViewModelList  = suburbs.map { SuburbViewModel(suburb: $0) }
                    
                    let tempCountryList       = suburbs.map { CountryViewModel(name: $0.country.name) }
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
    
}
