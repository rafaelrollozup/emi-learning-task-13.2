//
//  NetworkUtils.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias HTTPHeaders = [String : String]

extension HTTPURLResponse {
    /**
     A utility method to discover if the status code returned by the HTTP server is in the success range: 200 > status code >= 299
     */
    var inSuccessRange: Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}

extension Result {
    
    init(value: Success?, error: Failure?) {
        if let error = error {
            self = .failure(error)
            return
        }
        
        if let value = value {
            self = .success(value)
            return
        }

        fatalError("Could not possible to create a valid result")
    }
    
}

typealias HTTPRequestResult<Success> = Result<Success, NetworkError>

enum NetworkError: Error, LocalizedError {
    case unableToRequest(Error)
    case requestFailed(statusCode: Int)
    case invalidData(Error)
  
    var errorDescription: String? {
        switch self {
        case .unableToRequest(let error):
            return "Unable to perform the request. \(error.localizedDescription)"
        case .requestFailed:
            return "Request failed."
        case .invalidData:
            return "Unable to parse data of the request."
        }
    }
}
