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
    
    var rawValue: String {
        switch self {
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .genres:
            return "genre/movie/list"
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
