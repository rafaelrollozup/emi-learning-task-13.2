//
//  HTTPRequest.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

class HTTPRequest {
    
    private let urlTemplate: String = "https://casadocodigo-api.herokuapp.com/api%@"
    
    typealias URLSessionResult = Result<Data, Error>
    
    private var session: URLSession
    private var dataTask: URLSessionDataTask?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute<T: Decodable>(for resource: String,
                               httpMethod: HTTPMethod = .get,
                               httpHeaders: HTTPHeaders? = nil,
                               body encodable: Encodable? = nil,
                               decoder: JSONDecoder = JSONDecoder(),
                               encoder: JSONEncoder = JSONEncoder(),
                               completionHandler: @escaping (HTTPRequestResult<T>) -> Void) {
        dataTask?.cancel()
        
        let urlString = String(format: urlTemplate, resource)
        
        guard let url = URL(string: urlString) else {
            fatalError("Illegal state of the application: Unable to create URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let httpHeaders = httpHeaders {
            httpHeaders.forEach { (header, value) in request.setValue(value, forHTTPHeaderField: header) }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let encodable = encodable {
            do {
                let data = try encoder.encode(encodable)
                
                request.httpBody = data
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                
            } catch let error {
                debugPrint(error)
                let contextError = NetworkError.invalidData(error)
                
                completionHandler(.failure(.unableToRequest(contextError)))
                return
            }
        }
        
        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            let result: HTTPRequestResult<T> = URLSessionResult(value: data, error: error)
                .mapError { error in
                    return NetworkError.unableToRequest(error)
                }
                .flatMap { data in
                    return Result(catching: { try decoder.decode(T.self, from: data) })
                }
                .flatMapError { error in
                    if let error = error as? NetworkError {
                        return Result.failure(error)
                    }
                    
                    if let response = response as? HTTPURLResponse, !response.inSuccessRange {
                        return Result.failure(NetworkError.requestFailed(statusCode: response.statusCode))
                    }
                    
                    return Result.failure(.invalidData(error))
                }

            completionHandler(result)
        }
        
        dataTask?.resume()
    }
    
}

