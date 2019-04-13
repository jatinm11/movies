//
//  MovieCategoryCollectionViewCell.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class NowPlayingCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellScaling = 0.6
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    var category: MovieCategory? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let category = category {
            self.categoryNameLabel.text = category.categoryName
            self.collectionView.reloadData()
        }
    }
}

extension NowPlayingCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = self.category, let movies = category.movies else { return 0 }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = self.category, let movies = category.movies else { return UICollectionViewCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingDetailsCell", for: indexPath) as? NowPlayingMovieDetailsCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        cell.movie = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) + 40, height: collectionView.frame.height)
    }
}

