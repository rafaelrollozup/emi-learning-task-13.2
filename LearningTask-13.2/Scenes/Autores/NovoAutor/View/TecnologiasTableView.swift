//
//  TecnologiasTableView.swift
//  LearningTask-13.2
//
//

import UIKit

class TecnologiasTableView: UITableView {
        
    private lazy var adicionarTecnologiaButton: UIButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)
        
        var configuration = UIButton.Configuration.tinted()
        configuration.attributedTitle = AttributedString("Adicionar Tecnologia", attributes: container)
        configuration.image = .init(systemName: "plus")
        configuration.imagePadding = 8
        configuration.cornerStyle = .large
        configuration.baseBackgroundColor = .texasRose
        configuration.baseForegroundColor = .secondaryLabel
        
        let button = UIButton(frame: CGRect(x: .zero, y: .zero, width: .zero, height: 42))
        button.configuration = configuration
        return button
    }()
    
    var adicionarAction: UIAction? {
        didSet {
            guard let action = adicionarAction else { return }
            adicionarTecnologiaButton.addAction(action, for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TecnologiasTableView: ViewCode {
    
    func customizeAppearance() {
        separatorStyle = .none
        backgroundColor = .clear
    }
    
    func addSubviews() {
        tableFooterView = adicionarTecnologiaButton
    }
    
}
