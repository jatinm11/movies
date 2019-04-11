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

        MovieController.shared.searchMovieWith(query: "Shawshank Redemption") { (success) in
            if success {
                guard let searchedMovies = MovieController.shared.searchedMovies else { return }
                for i in searchedMovies {
                    print(i)
                }
            }
        }
    }
}

// 299537
