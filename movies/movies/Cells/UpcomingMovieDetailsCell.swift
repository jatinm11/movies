//
//  UpcomingMovieDetailsCell.swift
//  movies
//
//  Created by Jatin Menghani on 13/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class UpcomingMovieDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImageView.layer.cornerRadius = 10.0
        self.posterImageView.clipsToBounds = true
    }
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let movie = movie {
            DispatchQueue.main.async {
                self.movieNameLabel.text = movie.title
                if let posterPath = movie.posterPath {
                    self.posterImageView.downloadImage(imageType: .backdrop, path: posterPath)
                }
                else {
                    self.posterImageView.image = UIImage()
                }
                self.releaseDateLabel.text = "\(movie.releaseDate)"
            }
        }
    }
}
