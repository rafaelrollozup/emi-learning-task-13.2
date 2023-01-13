//
//  Validador.swift
//  LearningTask-13.2
//
//

import UIKit

typealias MensagemDeValidacao = String

struct ErroDeValidacao {
    let input: Validavel
    let mensagens: [MensagemDeValidacao]
    
    private init(input: Validavel, mensagens: [MensagemDeValidacao]) {
        self.input = input
        self.mensagens = mensagens
    }
    
    static func para(_ input: Validavel,
                     com mensagens: [MensagemDeValidacao]) -> ErroDeValidacao {
        return .init(input: input, mensagens: mensagens)
    }
}

class Validador {
    
    private(set) var views: [Validavel] = []
    private(set) var errosDeValidacao: [ErroDeValidacao] = []

    private func reset() {
        errosDeValidacao = []
    }

    private func valida(_ input: Validavel) {
        let mensagens = input.restricoes
            .compactMap { restricao in restricao.avalia(input.texto) }
            .map { template in String(format: template, input.rotulo) }
            .map { mensagem in mensagem.capitalizingFirst() }
        
        if mensagens.isEmpty {
            return
        }

        errosDeValidacao.append(ErroDeValidacao.para(input, com: mensagens))
    }

    func adiciona(_ input: Validavel) {
        views.append(input)
    }

    func estadoEhValido() -> Bool {
        reset()
        
        views.forEach { input in
            valida(input)
        }

        return errosDeValidacao.isEmpty
    }
    
    var mensagemPadrao: MensagemDeValidacao? {
        return errosDeValidacao.first?.mensagens.first
    }
    
}

enum Restricao {
    case naoVazio
    case urlValida
    case decimalValido
    case inteiroValido
    case dataValida(usando: DateFormatter.CustomPattern)
    case min(length: Int)
    case nomeCompletoValido

    func avalia(_ texto: String) -> String? {
        switch self {
        case .naoVazio:
            return texto.isEmpty ? "%@ não pode ser vazio." : nil
            
        case .urlValida:
            let url = URL(string: texto)
            return url == nil ? "Informe uma URL válida para %@." : nil
        
        case .decimalValido:
            let decimal = Decimal(string: texto)
            return decimal == nil ? "Informe um valor decimal válido para %@." : nil
            
        case .inteiroValido:
            let inteiro = Int(texto)
            return inteiro == nil ? "Informe um número válido para %@." : nil
        
        case .dataValida(let padrao):
            let data = Date.from(texto, using: padrao)
            return data == nil ? "Informe uma data válida para %@." : nil
            
        case .min(let length):
            return texto.count < length
                ? "Informe um valor para %@ com no mínimo \(length) caracteres."
                : nil
            
        case .nomeCompletoValido:
            let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: texto) ? nil : "Informe o nome completo para %@."
        }
    }
}
