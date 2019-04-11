//
//  Response.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import Foundation

struct GetMoviesResponse: Decodable {
    
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]?
    
}
