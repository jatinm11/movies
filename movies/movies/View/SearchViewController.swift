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
    
    var selectedMovie: Movie?
    
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        searchBar.delegate = self
    }
    
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "Sort By", message: "Select sort type", preferredStyle: .actionSheet)
        
        let sortByPopularityOption = UIAlertAction(title: "Popularity", style: .default) { (_) in
            if self.isSearching {
                self.sortSearchedMovies(by: .popularity)
            }
        }

        let sortByRatingOption = UIAlertAction(title: "Rating", style: .default) { (_) in
            if self.isSearching {
                self.sortSearchedMovies(by: .rating)
            }
        }
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            optionMenu.dismiss(animated: true, completion: nil)
        }
        
        let sortActions: [UIAlertAction] = [sortByRatingOption, sortByPopularityOption, cancelOption]
        sortActions.forEach({ optionMenu.addAction($0) })
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let destination = segue.destination as? MovieDetailsViewController {
                destination.movie = self.selectedMovie
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSearching {
            guard let searchedMovies = MovieController.shared.searchedMovies else { return }
            let searchedMovie = searchedMovies[indexPath.item]
            self.selectedMovie = searchedMovie
        }
        else {
            guard let nowPlayingCategory = MovieController.shared.nowPlayingCategory, let movies = nowPlayingCategory.movies else { return }
            let movie = movies[indexPath.item]
            self.selectedMovie = movie
        }
        
        self.performSegue(withIdentifier: "toDetailVC", sender: self)
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

extension SearchViewController {
    
    func sortSearchedMovies(by type: SortType) {
        if type == .popularity {
            MovieController.shared.searchedMovies!.sort(by: { $0.popularity > $1.popularity })
            UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadData()
            }, completion: nil)
        }
        if type == .rating {
            MovieController.shared.searchedMovies!.sort(by: { $0.voteAverage > $1.voteAverage })
            UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                self.collectionView.reloadData()
            }, completion: nil)
        }
    }
}

enum SortType {
    case popularity
    case rating
}
