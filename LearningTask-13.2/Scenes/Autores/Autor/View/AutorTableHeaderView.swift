//
//  AutorTableHeaderView.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class AutorTableHeaderView: UIView {
    
    static func constroi(para autor: Autor) -> AutorTableHeaderView {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 360)
        return AutorTableHeaderView(com: frame, e: autor)
    }
    
    // MARK: - Subviews
    private lazy var fotoImageView: UIView = {
        let tamanhoBase = CGSize.init(width: 120, height: 120)
    
        let imageView = UIImageView(frame: .init(origin: .zero, size: tamanhoBase))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setImageByDowloading(url: autor.fotoURI,
                                       placeholderImage: .init(named: "Avatar"),
                                       animated: true)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = tamanhoBase.width / 2
        
        imageView.constrainSize(to: tamanhoBase)
        
        let view = UIView()
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var fotoWrapperView: UIStackView = {
        let wrapperView = UIStackView(arrangedSubviews: [
            fotoImageView
        ])
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.axis = .vertical
        wrapperView.alignment = .center
        wrapperView.distribution = .fill
        return wrapperView
    }()
    
    private lazy var nomeLabel: UILabel = {
        let label = UILabel.SecondaryTitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = autor.nomeCompleto
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = autor.bio
        return label
    }()
    
    private lazy var tecnologiasView: ListaDeItensHorizontal = {
        let lista = ListaDeItensHorizontal()
        lista.translatesAutoresizingMaskIntoConstraints = false
        lista.titulo = "Escreve sobre:"
        lista.corDoTitulo = .secondaryLabel
        lista.itens = autor.tecnologias
        lista.constrainHeight(to: 56)
        return lista
    }()
    
    private lazy var containerView: UIStackView = {
        let dumbView = UIView()
        let stackview = UIStackView(arrangedSubviews: [
            fotoWrapperView,
            nomeLabel,
            bioLabel,
            dumbView,
            tecnologiasView
        ])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        return stackview
    }()

    // MARK: - Properties
    var autor: Autor
    
    // MARK: - Lifecycle
    private init(com frame: CGRect, e autor: Autor) {
        self.autor = autor
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AutorTableHeaderView: ViewCode {
    
    func customizeAppearance() {
        backgroundColor = .pampas
    }
    
    func addSubviews() {
        addSubview(containerView)
    }
    
    func addLayoutConstraints() {
        containerView.constrainTo(edgesOf: self)
    }
    
}
