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
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let runtime: Int
    let budget: Int
    let revenue: Int
    
    let productionCompanies: [ProductionCompanies]
    let productionCountry: [ProductionCountry]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case poster = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime = "runtime"
        case productionCompanies = "production_companies"
        case budget = "budget"
        case revenue = "revenue"
        case productionCountry = "production_countries"
    }
    
    struct ProductionCompanies: Codable {
        let logoPath: String
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
