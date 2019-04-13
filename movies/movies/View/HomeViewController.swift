//
//  HomeViewController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieCategories: [MovieCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        MovieController.shared.fetchMoviesFor(type: .nowPlaying) { (success) in
            if success {
                DispatchQueue.main.async {
                    guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory else { return }
                    self.movieCategories.append(nowPlayingCategory)
                    self.collectionView.reloadData()
                }
            }
        }
        
        MovieController.shared.fetchMoviesFor(type: .upcoming) { (success) in
            if success {
                DispatchQueue.main.async {
                    guard let upcomingCategory = MovieController.shared.upcomingCategory else { return }
                    self.movieCategories.append(upcomingCategory)
                    self.collectionView.reloadData()
                }
            }
        }
        
        MovieController.shared.fetchMoviesFor(type: .toprated) { (success) in
            if success {
                DispatchQueue.main.async {
                    guard let topRatedCategory = MovieController.shared.topRatedCategory else { return }
                    self.movieCategories.append(topRatedCategory)
                    self.collectionView.reloadData()
                }
            }
        }
        
        MovieController.shared.fetchMoviesFor(type: .popular) { (success) in
            if success {
                DispatchQueue.main.async {
                    guard let popularMoviesCategory = MovieController.shared.popularCategory else { return }
                    self.movieCategories.append(popularMoviesCategory)
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieCategories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCell", for: indexPath) as? NowPlayingCategoryCell else { return UICollectionViewCell() }
            
            let category = movieCategories[indexPath.item]
            cell.category = category
            return cell
        }
        
        if indexPath.item == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as? UpcomingCategoryCell else { return UICollectionViewCell() }
            let category = movieCategories[indexPath.item]
            cell.category = category
            return cell
        }
        
        if indexPath.item == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCell", for: indexPath) as? TopRatedCategoryCell else { return UICollectionViewCell() }
            
            let category = movieCategories[indexPath.item]
            cell.category = category
            return cell
        }
        
        if indexPath.item == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCategoryCell", for: indexPath) as? PopularCategoryCell else { return UICollectionViewCell() }
            
            let category = movieCategories[indexPath.item]
            cell.category = category
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        if indexPath.item == 0 || indexPath.item == 2 || indexPath.item == 3 {
            return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height / 2) + 140)
        }
        
        if indexPath.item == 1 {
            return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height / 3) + 100)
        }
        
        return CGSize(width: 0, height: 0)
    }
}
