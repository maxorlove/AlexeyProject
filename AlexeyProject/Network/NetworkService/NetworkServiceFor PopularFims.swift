//
//  NetworkService.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

protocol NetworkServicePopularFilms {
    func allPopularFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask
    func allLatestFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask
    func allUpcomingFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImplForPopularFilms: NetworkServicePopularFilms {

    func allPopularFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: PopularFilmsRequest(page: page), completion: completion)
        return request
    }
    
    func allLatestFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: LatestFilmsRequest(page: page), completion: completion)
        return request
    }
    
    func allUpcomingFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: UpcomingFilmsRequest(page: page), completion: completion)
        return request
    }
}


