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
    
    //MARK: - Property Declaration
    
    //view model containers
    private var suburbViewModelList: [SuburbViewModel]   = []
    private var countryViewModelList: [CountryViewModel] = []
    private var filteredSuburbList: [SuburbViewModel]    = []
    
    //stored country filter
    var countryFiltered: CountryViewModel?
    
    //sort descriptor
    var sortDescriptor: SortDescriptor = .alphabetically {
        didSet {
            sortFilteredSuburb()
        }
    }
    
    //lists counts
    var countryListCount: Int {
        return countryViewModelList.count
    }
    
    var filteredSuburbCount: Int {
        return filteredSuburbList.count
    }
    
    //MARK: - Controller Methods
    
    /**
     * Call network manager to fetch suburb and country info and store the fetched data inside our lists.
     * Since the main purpose of country list is to define the filter, we first create a view model that represents all country.
     *
     * - Parameters:
     *   - completion: Pass error if encountered, else, pass nil
     */
    func retrieveSuburbs(completion: @escaping (NPError?) -> Void) {
        NetworkManager.shared.getSuburbs { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let suburbs):
                    //store the fetched suburbs to our suburb and filtered suburb list
                    self.suburbViewModelList  = suburbs.map { SuburbViewModel(suburb: $0) }
                    self.filteredSuburbList = self.suburbViewModelList
                    
                    //grab the country data from our suburbs and store in country list
                    var tempCountryList       = [CountryViewModel(name: "All")]
                    tempCountryList.append(contentsOf: suburbs.map { CountryViewModel(name: $0.country.name) })
                    self.countryViewModelList = tempCountryList.uniqueElements
                    
                    completion(nil)
                case .failure(let error):
                    completion(error)
            }
        }
    }
    
    ///Retrieve suburb list
    func getSuburbList() -> [SuburbViewModel] {
        return suburbViewModelList
    }
    
    ///Retrive country list
    func getCountryList() -> [CountryViewModel] {
        return countryViewModelList
    }
    
    /**
     * Get the specific country in country list referenced by the passed index
     *
     * - Parameters:
     *   - index: index reference
     */
    func country(at index: Int) -> CountryViewModel {
        return countryViewModelList[index]
    }
    
    ///Retrieve filtered suburb list
    func getFilteredSuburbList() -> [SuburbViewModel] {
        return filteredSuburbList
    }
    
    /**
     * Filter suburb list based on the country passed. If the dummy all is selected, then
     * we just assigned the original suburb list. After filtering, we sort based on the last sorting descriptor
     *
     * - Parameters:
     *   - country: country information to filter
     */
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

    /**
     * Sort the filtered suburbs based on the manager's current sort descriptor. Alphabetically sorts from A to Z,
     * temperature sorts from coldest to hottest, and last update date sorts from current to oldest recorded update.
     *
     * Temperature considers nil values as 0 and missing update dates are assigned with the earliest recorded time interval.
     */
    func sortFilteredSuburb() {
        switch sortDescriptor {
            case .alphabetically: filteredSuburbList.sort { $0.suburbName < $1.suburbName }
            case .temperature: filteredSuburbList.sort { $0.weatherTemp! < $1.weatherTemp! }
            case .lastUpdate: filteredSuburbList.sort { $0.lastUpdated! > $1.lastUpdated! }
        }
    }
    
    /**
     * Filter suburb list based on the suburbName passed. This is primarily for the search function in main view controller
     *
     * - Parameters:
     *   - suburbName: string to compare to list of suburbs
     */
    func setFilteredSuburb(onSuburb suburbName: String) {
        filteredSuburbList = suburbViewModelList.filter {
            $0.suburbName.lowercased().contains(suburbName.lowercased())
        }
    }

    /**
     * Set our filter values to initial values
     */
    func setInitialFilterValues() {
        //our temporaray country representing all of the countries
        countryFiltered = CountryViewModel(name: "All")
        
        //also bring back filterList to original list
        filteredSuburbList = suburbViewModelList
    }
}
