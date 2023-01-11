//
//  File2.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

class AllFilmRequest: RequestModel {

    private var page: Int

    init(page: Int) {
        self.page = page
    }

    override var path: String {
        return "api/character"
    }

    override var parameters: [String : Any?] {
        return [
            "page": page
        ]
    }

    override var method: RequestHTTPMethod {
        return .get
    }
}
