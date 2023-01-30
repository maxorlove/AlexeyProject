//
//  File2.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

class PopularFilmsRequest: RequestModel {

    private var apiKey = "22df3e5437e8d86b8c6f7e75ab7f6243"
    private var language = "en-US"
    private var page: Int

    init(page: Int) {
        self.page = page
    }

    override var path: String {
        return "3/movie/popular"
    }

    override var parameters: [String : Any?] {
        return [
            "api_key=": "\(apiKey)",
            "language=": "\(language)",
            "page=": page
        ]
    }

    override var method: RequestHTTPMethod {
        return .get
    }
}
