//
//  Networking.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import Foundation

enum MovieType: String {
    
    case upcoming
    case nowPlaying
    case genres
    case toprated
    case popular
    
    var rawValue: String {
        switch self {
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .genres:
            return "genre/movie/list"
        case .toprated:
            return "movie/top_rated"
        case .popular:
            return "movie/popular"
        }
    }
}

enum APIError: Error {
    static let title = "Sorry!"
    
    case server
    case invalidRequest
    case badURL
    
    var description: String {
        switch (self) {
        case .server:
            return "It's not you, it's us..."
        case .invalidRequest:
            return "Invalid Request"
        default:
            return "Bad URL"
        }
    }
}

enum ImageType: String {
    case poster
    case backdrop
    case castImage
    
    var rawValue: String {
        switch self {
        case .poster:
            return "http://image.tmdb.org/t/p/w185"
        case .castImage:
            return "http://image.tmdb.org/t/p/w45"
        case .backdrop:
            return "http://image.tmdb.org/t/p/w780"
        }
    }
}

