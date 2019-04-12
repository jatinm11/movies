//
//  SearchViewController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        searchBar.delegate = self
    }
    
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "Sort By", message: "", preferredStyle: .actionSheet)
        
        let sortByRatingOption = UIAlertAction(title: "Rating", style: .default) { (_) in
            if self.isSearching {
                MovieController.shared.searchedMovies!.sort(by: { (movieOne, movieTwo) -> Bool in
                    return movieOne.voteAverage > movieTwo.voteAverage
                })
                UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                    self.collectionView.reloadData()
                }, completion: nil)
            }
        }
        let sortByPopularityOption = UIAlertAction(title: "Popularity", style: .default) { (_) in
            if self.isSearching {
                MovieController.shared.searchedMovies!.sort(by: { (movieOne, movieTwo) -> Bool in
                    return movieOne.popularity > movieTwo.popularity
                })
                UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                    self.collectionView.reloadData()
                }, completion: nil)
            }
        }
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .default) { (_) in
            optionMenu.dismiss(animated: true, completion: nil)
        }
        
        optionMenu.addAction(sortByRatingOption)
        optionMenu.addAction(sortByPopularityOption)
        optionMenu.addAction(cancelOption)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching {
            return MovieController.shared.searchedMovies!.count
        }
        else {
            guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory, let movies = nowPlayingCategory.movies, movies.count != 0 else { return 0 }
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchedMoviesCell", for: indexPath) as? SearchedMoviesCollectionViewCell else { return UICollectionViewCell() }
        
        if isSearching {
            guard let searchedMovies = MovieController.shared.searchedMovies else { return UICollectionViewCell() }
            let searchedMovie = searchedMovies[indexPath.item]
            cell.movie = searchedMovie
        }
        else {
            guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory, let movies = nowPlayingCategory.movies else { return UICollectionViewCell() }
            let movie = movies[indexPath.item]
            cell.movie = movie
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        return CGSize(width: (collectionView.frame.width / 2) - 7, height: collectionView.frame.height / 2)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text == ""{
            DispatchQueue.main.async {
                UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                    self.isSearching = false
                    self.view.endEditing(true)
                    self.collectionView.reloadData()
                    self.placeholderLabel.text = "Movies (Now Playing)"
                }, completion: nil)
            }
        }
        else {
            isSearching = true
            self.placeholderLabel.text = "Searching..."
            MovieController.shared.searchMovieWith(query: searchBar.text!) { (success) in
                if success {
                    DispatchQueue.main.async {
                        UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                            switch MovieController.shared.searchedMovies?.count {
                            case 0:
                                self.placeholderLabel.text = "No Movie(s) Found"
                            default:
                                self.placeholderLabel.text = "Search Results..."
                            }
                            self.collectionView.reloadData()
                            searchBar.resignFirstResponder()
                        }, completion: nil)
                    }
                }
            }
        }
    }
}
