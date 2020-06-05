//
//  WeatherViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/2/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    /// sole section to be used in our diffable data source
    enum Section { case main }
    
    //MARK: - Property Declaration
    
    var filterSortBarButton: UIBarButtonItem!
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    var datasource: UICollectionViewDiffableDataSource<Section, SuburbViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup views
    
    func setup() {
        setupView()
        setupConstraints()
        setupDatasource()
        setupObserver()
        
        retrieveSuburbs()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        
        //configure navigation bar
        title = NavTitle.weather
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //collectionView and layout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(SuburbCollectionViewCell.self, forCellWithReuseIdentifier: SuburbCollectionViewCell.reuseId)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        //refresh controller
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        //navigation button
        filterSortBarButton = UIBarButtonItem(image: SFSymbols.filterSort2, style: .plain, target: self, action: #selector(filterSortPressed))
        navigationItem.setRightBarButton(filterSortBarButton, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Listen to notification and perform a diff on our current data source
    func setupObserver() {
        NotificationCenter.default.addObserver(forName: .NPWeatherApplyFilterSort, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateData(using: ViewModelManager.shared.getFilteredSuburbList())
            }
        }
    }
    
    //MARK: - Controller methods
    
    /// Retrieve suburbs from network via ViewModel manager. If there's an error in fetch, we present an alert showing the error else, we update our dataSource.
    func retrieveSuburbs() {
        ViewModelManager.shared.retrieveSuburbs { [weak self] error in
            guard error == nil else {
                self?.presentAlert(withTitle: "Weather Information Error", andMessage: error!.rawValue, buttonTitle: "Ok")
                return
            }
            
            self?.updateData(using: ViewModelManager.shared.getSuburbList())
        }
    }
    
    /// Show filter and sort view controller
    @objc func filterSortPressed() {
        let filterAndSortVC = FilterSortViewController()
        let navController = UINavigationController(rootViewController: filterAndSortVC)
        present(navController, animated: true)
    }
    
    /// Refresh our dataSource. Call retrieveSuburb when user pull's down the collection view to update suburb list.
    @objc func refreshCollection() {
        retrieveSuburbs()
        collectionView.refreshControl?.endRefreshing()
    }
}

//MARK: - View Controller Extension

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - DataSource and Snapshot Configuration
    
    /// Initialize our data source. We also setup our custom cell to be used in our collection view referenced by the data source
    func setupDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, SuburbViewModel>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, suburbViewModel) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuburbCollectionViewCell.reuseId, for: indexpath) as! SuburbCollectionViewCell
            cell.suburbViewModel = suburbViewModel
            return cell
            
        })
    }
    
    /**
     * Create and apply a diff onto the snapshot using our current datasource and the list passed.
     *
     * - Parameters:
     *   - suburbList: list to diff our current suburbList to
     */
    func updateData(using suburbList: [SuburbViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SuburbViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(suburbList)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth  = collectionView.frame.width * 0.85
        let cellHeight = collectionView.frame.height * 0.15
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get our view model in the datasource pointed to by the selected indexPath
        guard let suburbViewModel = datasource.itemIdentifier(for: indexPath) else { return }
        
        // Initialize our Weather Info VC and make it as root to our Navigation Controller
        let weatherInfoVC = WeatherInfoViewController()
        let navController = UINavigationController(rootViewController: weatherInfoVC)
        
        // Pass the view model to our weather info VC mainly to bind the values into the properties.
        weatherInfoVC.suburbViewModel = suburbViewModel
        
        present(navController, animated: true)
    }
}

