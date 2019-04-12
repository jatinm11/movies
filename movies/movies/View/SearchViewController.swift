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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
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
}
