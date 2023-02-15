//
//  FilmDetailsRequest.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 11.01.2023.
//

import Foundation

class FilmDetailsRequest: RequestModel {
    
    //MARK: - Private Methods
    private var apiKey = "22df3e5437e8d86b8c6f7e75ab7f6243"
    private var language = "en-US"
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    override var path: String {
        return "3/movie/\(id)"
    }

    override var parameters: [String : Any?] {
        return [
            "api_key=": "\(apiKey)",
            "language=": "\(language)"
        ]
    }

    override var method: RequestHTTPMethod {
        return .get
    }
}

