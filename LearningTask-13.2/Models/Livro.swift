//
//  Livro.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

enum TipoDeLivro: String, CaseIterable, Codable {
    case ebook = "EBOOK"
    case impresso = "HARDCOVER"
    case combo = "COMBO"
    
    var index: Int {
        switch self {
        case .ebook:
            return 0
        case .impresso:
            return 1
        case .combo:
            return 2
        }
    }
    
    var titulo: String {
        switch self {
        case .ebook:
            return "E-book"
        case .impresso:
            return "Impresso"
        case .combo:
            return "E-book + impresso"
        }
    }
}

struct Preco: Codable {
    let valor: Decimal
    let tipoDeLivro: TipoDeLivro
    
    enum CodingKeys: String, CodingKey {
        case valor = "value"
        case tipoDeLivro = "bookType"
    }
}

struct Livro: Codable {
    let id: Int?
    let titulo: String
    let subtitulo: String
    let imagemDeCapaURI: URL
    let autor: Autor
    let precos: [Preco]
    let descricao: String
    let numeroDePaginas: Int
    let dataDePublicacao: Date
    let isbn: String
    
    init(id: Int? = nil, titulo: String, subtitulo: String, imagemDeCapaURI: URL, autor: Autor, precos: [Preco], descricao: String, numeroDePaginas: Int, dataDePublicacao: Date, isbn: String) {
        self.id = id
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.imagemDeCapaURI = imagemDeCapaURI
        self.autor = autor
        self.precos = precos
        self.descricao = descricao
        self.numeroDePaginas = numeroDePaginas
        self.dataDePublicacao = dataDePublicacao
        self.isbn = isbn
    }
    
    func valor(para tipoDeLivro: TipoDeLivro) -> Decimal {
        return precos.filter({ tipoDeLivro == $0.tipoDeLivro }).first!.valor
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titulo = "title"
        case subtitulo = "subtitle"
        case imagemDeCapaURI = "coverImagePath"
        case autor = "author"
        case precos = "prices"
        case descricao = "description"
        case numeroDePaginas = "numberOfPages"
        case dataDePublicacao = "publicationDate"
        case isbn
    }
}
