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
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.posterImageView.layer.cornerRadius = 10.0
        self.posterImageView.clipsToBounds = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
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
            self.dateAndReleaseLabel.text = "Release Date: \(movie.releaseDate)"
            self.overviewLabel.text = movie.overview
            
            if movie.voteAverage == 0 {
                self.ratingLabel.text = "TBD"
            }
            else {
                self.ratingLabel.text = "\(movie.voteAverage)"
            }
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.movie = nil
        self.dismiss(animated: true, completion: nil)
    }
}
