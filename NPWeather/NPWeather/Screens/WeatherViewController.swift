//
//  WeatherViewController.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/2/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    enum Section { case main }
    
    var filterSortBarButton: UIBarButtonItem!
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, SuburbViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
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
    
    func setupObserver() {
        NotificationCenter.default.addObserver(forName: .NPWeatherApplyFilterSort, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateData(using: ViewModelManager.shared.getFilteredSuburbList())
            }
        }
    }
    
    func retrieveSuburbs() {
        ViewModelManager.shared.retrieveSuburbs { [weak self] error in
            guard error == nil else {
                self?.presentAlert(withTitle: "Weather Information Error", andMessage: error!.rawValue, buttonTitle: "Ok")
                return
            }
            
            self?.updateData(using: ViewModelManager.shared.getSuburbList())
            
        }
    }
    
    @objc func filterSortPressed() {
        let filterAndSortVC = FilterSortViewController()
        let navController = UINavigationController(rootViewController: filterAndSortVC)
        present(navController, animated: true)
    }
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, SuburbViewModel>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, suburbViewModel) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuburbCollectionViewCell.reuseId, for: indexpath) as! SuburbCollectionViewCell
            cell.suburbViewModel = suburbViewModel
            return cell
            
        })
    }
    
    func updateData(using suburbList: [SuburbViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SuburbViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(suburbList)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth  = collectionView.frame.width * 0.85
        let cellHeight = collectionView.frame.height * 0.15
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let suburbViewModel = datasource.itemIdentifier(for: indexPath) else { return }
        
        let weatherInfoVC = WeatherInfoViewController()
        let navController = UINavigationController(rootViewController: weatherInfoVC)
        
        weatherInfoVC.suburbViewModel = suburbViewModel
        
        present(navController, animated: true)
    }
}

