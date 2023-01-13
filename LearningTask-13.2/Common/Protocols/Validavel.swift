//
//  Validavel.swift
//  LearningTask-13.2
//
//

import UIKit

protocol Validavel: UIView {
    var rotulo: String { get }
    var texto: String { get }
    var restricoes: [Restricao] { get }
}
