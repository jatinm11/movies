//
//  TestViewController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MovieController.shared.fetchMovieDetails(movieId: 299537) { (success) in
            if success {
                guard let movieDetails = MovieController.shared.movieDetails else { return }
                print(movieDetails)
            }
        }
    }
}

// 299537
