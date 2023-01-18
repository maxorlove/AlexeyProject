//
//  NetworkSeviceForFilm.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 16.01.2023.
//

import Foundation

protocol NetworkServiceForFilm {
    func film(id: Int, completion: @escaping(Result<FilmResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImpForFilm: NetworkServiceForFilm {

    func film(id: Int, completion: @escaping(Result<FilmResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: FilmDetailsRequest(id: id), completion: completion)
        return request
    }
}
