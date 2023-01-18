//
//  NetworkServiceForUpcomingFilms.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 17.01.2023.
//

//import Foundation
//
//protocol NetworkServiceUpcomingFilms {
//    func allFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask
//}
//
//class NetworkServiceImplForUpcomingFilms: NetworkServiceUpcomingFilms {
//
//    func allFilms(page: Int, completion: @escaping(Result<FilmsResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
//        let request = ServiceManager.shared.sendRequest(request: UpcomingFilmsRequest(page: page), completion: completion)
//        return request
//    }
//}
