//
//  AutoresAPI.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

class AutoresAPI {
    
    private let userAuthentication: UserAuthentication
    private let httpRequest: HTTPRequest
    
    init(userAuthentication: UserAuthentication = .init(),
         httpRequest: HTTPRequest = .init()) {
        self.userAuthentication = userAuthentication
        self.httpRequest = httpRequest
    }

    func listaTodos(completionHandler: @escaping (AutoresAPI.Result<[Autor]>) -> Void,
                    completeOn completionQueue: DispatchQueue = .main) {
        httpRequest.execute(for: "/author") { (result: HTTPRequestResult<[Autor]>) in
            switch result {
            case .success(let autores):
                completionQueue.async {
                    completionHandler(.success(autores))
                }
                
            case .failure(let erro):
                debugPrint(erro)
                
                completionQueue.async {
                    completionHandler(.failure(.falhaAoExecutar(erro)))
                }
            }
        }
    }
    
    func registraNovo(_ autor: Autor,
                  completionHandler: @escaping (AutoresAPI.Result<Autor>) -> Void,
                  completeOn completionQueue: DispatchQueue = .main) {
        
        guard let authentication = userAuthentication.get() else {
            preconditionFailure("Estado ilegal para a aplicação: Usuário deve estar logado")
        }
        
        let headers = ["Authorization": authentication.value]
        
        httpRequest.execute(for: "/author",
                            httpMethod: .post,
                            httpHeaders: headers,
                            body: autor) { (result: HTTPRequestResult<Autor>) in
            switch result {
            case .success(let novoAutor):
                completionQueue.async {
                    completionHandler(.success(novoAutor))
                }
                
            case .failure(let erro):
                debugPrint(erro)
                
                completionQueue.async {
                    completionHandler(.failure(.falhaAoExecutar(erro)))
                }
            }
        }
    }
    
}

extension AutoresAPI {
    typealias Result<Success> = Swift.Result<Success, AutoresAPI.Error>

    enum Error: Swift.Error, LocalizedError {
        case falhaAoExecutar(NetworkError)

        var errorDescription: String? {
            switch self {
            case .falhaAoExecutar(let erro):
                return erro.localizedDescription
            }
        }
    }
}
