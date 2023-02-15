//
//  FilmResponse.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.01.2023.
//

import Foundation

struct FilmResponse: Codable {
    let title: String
    let poster: String
    let description: String
    let releaseDate: String
    let voteAverage: Double
    let runtime: Int
    let budget: Int
    let revenue: Int
    let voteCount: Int
    let popularity: Double
    let originalLanguage: String
    
    let productionCompanies: [ProductionCompanies]
    let productionCountry: [ProductionCountry]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case poster = "poster_path"
        case description = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime = "runtime"
        case budget = "budget"
        case revenue = "revenue"
        case productionCompanies = "production_companies"
        case productionCountry = "production_countries"
        case voteCount = "vote_count"
        case popularity = "popularity"
        case originalLanguage = "original_language"
    }
    
    struct ProductionCompanies: Codable {
        let logoPath: String?
        let name: String

        enum CodingKeys: String, CodingKey {
            case logoPath = "logo_path"
            case name = "name"
        }
    }

    struct ProductionCountry: Codable {
        let name: String
    }
}
