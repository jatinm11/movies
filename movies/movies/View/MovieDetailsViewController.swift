//
//  MovieDetailsViewController.swift
//  movies
//
//  Created by Jatin Menghani on 14/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateAndReleaseLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.posterImageView.layer.cornerRadius = 10.0
        self.posterImageView.clipsToBounds = true
        
        updateViews()
    }
    
    func updateViews() {
        if let movie = movie {
            if let posterPath = movie.posterPath {
                self.posterImageView.downloadImage(imageType: .poster, path: posterPath)
            }
            else {
                self.posterImageView.image = UIImage()
            }
            
            self.titleLabel.text = movie.title
            self.dateAndReleaseLabel.text = "\(movie.releaseDate)"
        }
    }
}
