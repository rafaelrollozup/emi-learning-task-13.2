//
//  InputView.swift
//  LearningTask-13.2
//
//

import Foundation


import UIKit

class InputView: UIView {
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel.Span()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    var titulo: String? {
        didSet {
            tituloLabel.text = titulo
        }
    }
    
    var input: Validavel? {
        didSet {
            guard let input = input else { return }
            containerStackView.addArrangedSubview(input)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InputView: ViewCode {
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(edgesOf: self)
    }
    
}
