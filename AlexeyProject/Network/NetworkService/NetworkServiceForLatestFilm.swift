//
//  NetworkServiceForLatestFilm.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 17.01.2023.
//

//import Foundation
//
//protocol NetworkServiceLatestFilms {
//    func allFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask
//}
//
//class NetworkServiceImplForLatestFilms: NetworkServiceLatestFilms {
//
//    func allFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
//        let request = ServiceManager.shared.sendRequest(request: LatestFilmsRequest(page: page), completion: completion)
//        return request
//    }
//}
