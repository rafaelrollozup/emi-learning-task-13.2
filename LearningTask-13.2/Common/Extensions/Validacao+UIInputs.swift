//
//  Validacao+UIInputs.swift
//  LearningTask-13.2
//
//

import UIKit

extension UITextField {
    
    class Valido: UITextField, Validavel {
        var rotulo: String
        
        var texto: String {
            return self.text ?? ""
        }
        
        var restricoes: [Restricao]
            
        init(rotulo: String, aplicando restricoes: [Restricao]) {
            self.rotulo = rotulo
            self.restricoes = restricoes
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}

extension UITextView {
    
    class Valida: UITextView, Validavel {
        var rotulo: String
        
        var texto: String {
            return self.text ?? ""
        }
        
        var restricoes: [Restricao]
        
        init(rotulo: String, aplicando restricoes: [Restricao]) {
            self.rotulo = rotulo
            self.restricoes = restricoes
            super.init(frame: .zero, textContainer: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}
