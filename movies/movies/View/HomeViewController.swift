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
        //
        //        MovieController.shared.fetchMoviesFor(type: .upcoming) { (success) in
        //            if success {
        //                DispatchQueue.main.async {
        //                    guard let upcomingCategory = MovieController.shared.upcomingCategory else { return }
        //                    self.movieCategories.append(upcomingCategory)
        //                    self.collectionView.reloadData()
        //                }
        //            }
        //        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieCategories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? MovieCategoryCollectionViewCell else { return UICollectionViewCell() }
        
        let category = movieCategories[indexPath.item]
        cell.category = category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 343, height: 350)
        }
        return CGSize(width: 343, height: 200)
    }
}
