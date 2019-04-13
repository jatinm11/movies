//
//  UpcomingMoviesCollectionViewCell.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class UpcomingCategoryCell: NowPlayingCategoryCell {
    
    override var category: MovieCategory? {
        didSet {
            updateViews()
        }
    }
    
    override func updateViews() {
        if let category = category {
            DispatchQueue.main.async {
                self.categoryNameLabel.text = category.categoryName
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let category = self.category, let movies = category.movies else { return 0 }
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let category = self.category, let movies = category.movies else { return UICollectionViewCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingDetailsCell", for: indexPath) as? UpcomingMovieDetailsCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        cell.movie = movie
        return cell
    }
}
