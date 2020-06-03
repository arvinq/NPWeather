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
        
        retrieveSuburbs()
    }

    func setupView() {
        view.backgroundColor = .systemBackground
        
        //configure navigation bar
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //collectionView and layout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.register(SuburbCollectionViewCell.self, forCellWithReuseIdentifier: SuburbCollectionViewCell.reuseId)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
    }
    
    func setupConstraints() {
        
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
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, SuburbViewModel>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, suburbViewModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuburbCollectionViewCell.reuseId, for: indexpath)
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
        
        let cellWidth  = collectionView.frame.width * 0.8
        let cellHeight = collectionView.frame.height * 0.2
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

