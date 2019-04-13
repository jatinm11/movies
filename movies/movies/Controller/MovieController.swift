//
//  MovieController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import Foundation

class MovieController {
    
    static let shared = MovieController()
    
    var upcomingCategory: MovieCategory?
    var nowPlayingCategory: MovieCategory?
    var topRatedCategory: MovieCategory?
    var popularCategory: MovieCategory?
    var movieDetails: MovieDetails?
    
    var searchedMovies: [Movie]? = []
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    let apiKey = "7f92a096158dcb0a254d7038aeabed0b"
    
    func fetchMoviesFor(type: MovieType, completion: @escaping(_ success: Bool) -> Void) {
        
        let base = baseURL.appendingPathComponent(type.rawValue)
        var urlComponents = URLComponents(url: base, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: "US")
        ]
        
        guard let url = urlComponents?.url else {
            completion(false)
            return
        }
        
        print(url)
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let movies = try decoder.decode(GetMoviesResponse.self, from: data)
                if let results = movies.results {
                    if type == MovieType.upcoming {
                        let upcomingCategory = MovieCategory(categoryName: "Upcoming Movies", movies: results)
                        self.upcomingCategory = upcomingCategory
                        
                    }
                    else if type == MovieType.nowPlaying {
                        let nowPlayingCategory = MovieCategory(categoryName: "Now Playing", movies: results)
                        self.nowPlayingCategory = nowPlayingCategory
                    }
                    else if type == MovieType.toprated {
                        let topRatedCategory = MovieCategory(categoryName: "Top Rated", movies: results)
                        self.topRatedCategory = topRatedCategory
                    }
                    else if type == MovieType.popular {
                        let popularCategory = MovieCategory(categoryName: "Popular", movies: results)
                        self.popularCategory = popularCategory
                    }
                    
                    completion(true)
                }
            }
            catch let error {
                print(error)
                completion(false)
                return
            }
        }
        dataTask.resume()
    }
    
    
    func fetchMovieDetails(movieId: Int, completion: @escaping(_ success: Bool) -> Void) {
        
        let base = "\(baseURL)movie/\(movieId)?api_key=\(apiKey)&language=en-US&append_to_response=credits,release_dates"
        
        guard let url = URL(string: base) else { completion(false); return }
        
        print(url)
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let data = data else { completion(false); return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                self.movieDetails = movieDetails
                completion(true)
            }
            catch let error {
                print(error.localizedDescription)
                completion(false)
                return
            }
        }
        dataTask.resume()
    }
    
    func searchMovieWith(query: String, completion: @escaping(_ success: Bool) -> Void) {
        
        let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=7f92a096158dcb0a254d7038aeabed0b&language=en-US&query=\(query)&page=1"
        let queryURL = baseURL.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: queryURL)!
        
        print(url)
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let data = data else { completion(false); return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let response = try decoder.decode(GetMoviesResponse.self, from: data)
                if let movies = response.results {
                    self.searchedMovies = movies
                    completion(true)
                }
            }
            catch let error {
                print(error.localizedDescription)
                completion(false)
                return
            }
        }
        
        dataTask.resume()
    }
    
}
