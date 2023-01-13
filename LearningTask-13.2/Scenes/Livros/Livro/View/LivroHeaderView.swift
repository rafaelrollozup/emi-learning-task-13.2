//
//  LivroHeaderView.swift
//  LearningTask-13.2
//
//

import UIKit

class LivroHeaderView: UIView {
    
    private lazy var tituloDoLivroLabel: UILabel = {
        let label = UILabel.Title()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtituloDoLivroLabel: UILabel = {
        let label = UILabel.Subtitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var autorLabel: UILabel = {
        let label = UILabel.Emphasize()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titulosStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tituloDoLivroLabel,
            subtituloDoLivroLabel,
            autorLabel,
            UIView()
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var capaImageView: CapaImageView = {
        let imageView = CapaImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constrainHeight(to: 180)
        return imageView
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titulosStackView, capaImageView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contentContainerStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }
            
            tituloDoLivroLabel.text = livro.titulo
            subtituloDoLivroLabel.text = livro.subtitulo
            autorLabel.text = livro.autor.nomeCompleto
            
            capaImageView.setImageByDowloading(url: livro.imagemDeCapaURI, animated: true)
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

extension LivroHeaderView: ViewCode {
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(edgesOf: self)
    }
    
}
