//
//  MovieCategoryCollectionViewCell.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class NowPlayingMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellScaling = 0.6
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
//        let collectionViewSize = collectionView.frame.size
//        let cellWidth = floor(Double(collectionViewSize.width) * cellScaling)
//        let cellHeight = floor(Double(collectionViewSize.height) * cellScaling)
//
//        let insetX = (Double(collectionView.bounds.width) - cellWidth) / 2.0
//        let insetY = (Double(collectionView.bounds.height) - cellHeight) / 2.0
//
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        collectionView.contentInset = UIEdgeInsets(top: CGFloat(insetY), left: CGFloat(insetX), bottom: CGFloat(insetY), right: CGFloat(insetX))
        
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

extension NowPlayingMoviesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = self.category, let movies = category.movies else { return 0 }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = self.category, let movies = category.movies else { return UICollectionViewCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        cell.movie = movie
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) + 40, height: collectionView.frame.height)
    }
}

