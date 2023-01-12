//
//  LivrosAPI.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

fileprivate extension Livro {
    
    struct Request: Encodable {
        let coverImagePath: URL
        let title: String
        let subtitle: String
        let authorId: Int
        let description: String
        let eBookPrice: Decimal
        let hardcoverPrice: Decimal
        let comboPrice: Decimal
        let numberOfPages: Int
        let publicationDate: Date
        let isbn: String
    }
    
    func toRequest() -> Encodable {
        return Livro.Request(
            coverImagePath: self.imagemDeCapaURI,
            title: self.titulo,
            subtitle: self.subtitulo,
            authorId: self.autor.id!,
            description: self.descricao,
            eBookPrice: self.valor(para: .ebook),
            hardcoverPrice: self.valor(para: .impresso),
            comboPrice: self.valor(para: .combo),
            numberOfPages: self.numeroDePaginas,
            publicationDate: self.dataDePublicacao,
            isbn: self.isbn
        )
    }
    
}

class LivrosAPI {
    
    private let userAuthentication: UserAuthentication
    private let httpRequest: HTTPRequest
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(userAuthentication: UserAuthentication = .init(),
         httpRequest: HTTPRequest = .init(),
         decoder: JSONDecoder = .decodingFormattedDates(with: .dayMonthAndYear),
         encoder: JSONEncoder = .encodingFormattedDates(with: .dayMonthAndYear)) {
        self.userAuthentication = userAuthentication
        self.httpRequest = httpRequest
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func carregaTodos(completionHandler: @escaping (LivrosAPI.Result<[Livro]>) -> Void,
                      completeOn completionQueue: DispatchQueue = .main) {
        httpRequest.execute(for: "/book",
                            decoder: decoder) { (result: HTTPRequestResult<[Livro]>) in
            switch result {
            case .success(let livros):
                completionQueue.async {
                    completionHandler(.success(livros))
                }
                
            case .failure(let error):
                debugPrint(error)
                
                completionQueue.async {
                    completionHandler(.failure(.falhaAoExecutar(error)))
                }
            }
        }
    }
    
    func carregaLivros(porAutorId id: Int,
                       completionHandler: @escaping (LivrosAPI.Result<[Livro]>) -> Void,
                       completeOn completionQueue: DispatchQueue = .main) {
        let endpoint = String(format: "/author/%d/books", id)
        
        httpRequest.execute(for: endpoint,
                            decoder: decoder) { (result: HTTPRequestResult<[Livro]>) in
            switch result {
            case .success(let livros):
                completionQueue.async {
                    completionHandler(.success(livros))
                }
                
            case .failure(let error):
                debugPrint(error)
                
                completionQueue.async {
                    completionHandler(.failure(.falhaAoExecutar(error)))
                }
            }
        }
    }
    
    func registraNovo(_ livro: Livro,
                      completionHandler: @escaping (LivrosAPI.Result<Livro>) -> Void,
                      completeOn completionQueue: DispatchQueue = .main) {
        
        guard let authentication = userAuthentication.get() else {
            preconditionFailure("Estado ilegal para a aplicação: Usuário deve estar logado")
        }
        
        let headers = ["Authorization": authentication.value]
        
        httpRequest.execute(for: "/book",
                            httpMethod: .post,
                            httpHeaders: headers,
                            body: livro.toRequest(),
                            decoder: decoder,
                            encoder: encoder) { (result: HTTPRequestResult<Livro>) in
            switch result {
            case .success(let novoLivro):
                completionQueue.async {
                    completionHandler(.success(novoLivro))
                }
                
            case .failure(let error):
                debugPrint(error)
                
                completionQueue.async {
                    completionHandler(.failure(.falhaAoExecutar(error)))
                }
            }
        }
    }
    
}

extension LivrosAPI {
    typealias Result<Success> = Swift.Result<Success, LivrosAPI.Error>
    
    enum Error: Swift.Error, LocalizedError {
        case falhaAoExecutar(NetworkError)
        
        var errorDescription: String? {
            switch self {
            case .falhaAoExecutar(let error):
                return error.localizedDescription
            }
        }
    }
}
