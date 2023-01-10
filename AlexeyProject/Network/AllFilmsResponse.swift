//
//  Model.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

struct AllFilmsResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
}

struct Info: Codable {
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "pages"
    }
}

