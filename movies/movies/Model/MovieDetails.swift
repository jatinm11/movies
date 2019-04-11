//
//  MovieDetails.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import Foundation

struct MovieDetails: Decodable {
    let credits: Credits
    let productionCompanies: [ProductionCompany]
    let releaseDates: ReleaseDates
    let runtime: Int?
}

struct Credits: Decodable {
    let cast: [CastMember]
    let crew: [CrewMember]
}

struct CastMember: Decodable {
    let name: String
    let profilePath: String?
}

struct CrewMember: Decodable {
    let name: String
    let job: String
}

struct ProductionCompany: Decodable {
    let name: String
}

// the movie rating (PG, R etc...) is found under release dates endpoint
struct ReleaseDates: Decodable {
    let results: [Certification]
}

struct Certification: Decodable {
    let releaseDates: [RatingDetails]
    let iso31661: String
}

struct RatingDetails: Decodable {
    let certification: String
}

