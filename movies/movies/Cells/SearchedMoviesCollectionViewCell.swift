//
//  SearchedMoviesCollectionViewCell.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class SearchedMoviesCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let movie = movie {
            self.movieNameLabel.text = movie.title
            self.posterImageView.downloadImage(imageType: .backdrop, path: movie.posterPath!)
            self.movieLengthLabel.text = "\(movie.length ?? "0")"
        }
    }
}
