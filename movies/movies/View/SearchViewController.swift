//
//  SearchViewController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory, let movies = nowPlayingCategory.movies, movies.count != 0 else { return 0 }
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchedMoviesCell", for: indexPath) as? SearchedMoviesCollectionViewCell else { return UICollectionViewCell() }
        
        guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory, let movies = nowPlayingCategory.movies else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.item]
        cell.movie = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        return CGSize(width: (collectionView.frame.width / 2) - 7, height: collectionView.frame.height / 2)
        
    }
}
