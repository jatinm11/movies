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

        MovieController.shared.fetchMoviesFor(type: MovieType.nowPlaying) { (success) in
            if success {
                guard let nowPlayingMovies = MovieController.shared.nowPlayingCategory else { return }
                for i in nowPlayingMovies.movies! {
                    print(i.title)
                }
            }
        }
    }
}
