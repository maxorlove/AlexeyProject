//
//  File3.swift
//  AlexeyProject
//
//  Created by Алексей Шумилов on 04.01.2023.
//

import Foundation

class ServiceManager {

    public static let shared: ServiceManager = ServiceManager()

    public var baseImageURL: String = "https://image.tmdb.org/t/p/original"
    public var baseURL: String = "https://api.themoviedb.org/"
}

extension ServiceManager {

    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) -> URLSessionDataTask {

        let task = URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            let decoder = JSONDecoder()
            guard
                let data = data,
                  let decodedModel = try? decoder.decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)

                completion(.failure(error))
                return
            }

            completion(.success(decodedModel))
        }
        task.resume()
        return task
    }
    
}
