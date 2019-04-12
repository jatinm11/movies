//
//  UpcomingMoviesCollectionViewCell.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class UpcomingMoviesCollectionViewCell: NowPlayingMoviesCollectionViewCell {
    
    override var category: MovieCategory? {
        didSet {
            updateViews()
        }
    }
    
    override func updateViews() {
        if let category = category {
            self.categoryNameLabel.text = category.categoryName
            self.collectionView.reloadData()
        }
    }
}
