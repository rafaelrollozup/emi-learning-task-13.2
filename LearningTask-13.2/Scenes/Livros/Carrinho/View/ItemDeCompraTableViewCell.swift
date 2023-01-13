//
//  ItemDeCompraTableViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class ItemDeCompraTableViewCell: UITableViewCell {
    
    private lazy var capaDoLivroImageView: CapaImageView = {
        let imageView = CapaImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constrainHeight(to: 150)
        return imageView
    }()
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel.Emphasize()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nomeDoAutorLabel: UILabel = {
        let label = UILabel.Span()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tipoDeLivroLabel: UILabel = {
        let label = UILabel.Span()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var precoDoLivroLabel: UILabel = {
        let label = UILabel.Strong()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var informacoesStackView: UIStackView = {
        let titulosStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [
                tituloLabel,
                nomeDoAutorLabel,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        let itemDeCompraStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [
                tipoDeLivroLabel,
                precoDoLivroLabel,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        let stackView = UIStackView(arrangedSubviews: [
            titulosStackView,
            itemDeCompraStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            capaDoLivroImageView,
            informacoesStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    var itemDeCompra: ItemDeCompra? {
        didSet {
            guard let itemDeCompra = itemDeCompra else { return }
            
            let livro = itemDeCompra.livro
            
            capaDoLivroImageView.setImageByDowloading(url: livro.imagemDeCapaURI, placeholderImage: .init(named: "Book"))
            
            tituloLabel.text = livro.titulo
            nomeDoAutorLabel.text = livro.autor.nomeCompleto
            
            tipoDeLivroLabel.text = itemDeCompra.tipoDeLivro.titulo
            precoDoLivroLabel.text = NumberFormatter.formatToCurrency(decimal: itemDeCompra.preco)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ItemDeCompraTableViewCell: ReusableView {}

extension ItemDeCompraTableViewCell: ViewCode {
    
    func customizeAppearance() {
        backgroundColor = .pampas
    }
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(edgesOf: self)
    }
    
}
