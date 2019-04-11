//
//  Movie.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    var voteCount: Int
    var id: Int
    var video: Bool
    var voteAverage: Double
    var title: String
    var popularity: Double
    var posterPath: String?
    var genreIds: [Int]
    var backdropPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String
    
    var cast: [CastMember]?
    var directors: String?
    var productionCompanies: String?
    var mpaaRating: String?
    var length: String?

}
