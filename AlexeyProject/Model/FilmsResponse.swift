//
//  Model.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

struct FilmsResponse: Codable {
    let results: [Film]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case totalPages = "total_pages"
    }
}

struct Film: Codable {
    let id: Int
    let overview: String
    let poster: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
    }
}


