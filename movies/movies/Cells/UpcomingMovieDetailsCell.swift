//
//  UpcomingMovieDetailsCell.swift
//  movies
//
//  Created by Jatin Menghani on 13/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class UpcomingMovieDetailsCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
    
}
