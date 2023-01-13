//
//  PrecosDoLivroView.swift
//  LearningTask-13.2
//
//

import UIKit

protocol PrecosDoLivroViewDelegate: AnyObject {
    func precosDoLivroView(_ view: PrecosDoLivroView, selecionouTipo tipoDeLivro: TipoDeLivro)
}

class PrecosDoLivroView: UIView {
    
    // MARK: - Subviews
    private lazy var marginsPrecos: UIEdgeInsets = {
        return .init(top: .zero, left: 20, bottom: .zero, right: 20)
    }()
    
    private lazy var precoEbookView: OfertaDePrecoView = {
        let view = OfertaDePrecoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.margins = marginsPrecos
        view.titulo = "E-book*"
        view.action = UIAction { [weak self] _ in
            self?.delegate?.precosDoLivroView(self!, selecionouTipo: .ebook)
        }
        return view
    }()
    
    private lazy var precoImpressoView: OfertaDePrecoView = {
        let view = OfertaDePrecoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.margins = marginsPrecos
        view.titulo = "Impresso"
        view.action = UIAction { [weak self] _ in
            self?.delegate?.precosDoLivroView(self!, selecionouTipo: .impresso)
        }
        return view
    }()
    
    private lazy var precoComboView: OfertaDePrecoView = {
        let view = OfertaDePrecoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.margins = marginsPrecos
        view.titulo = "E-book + Impresso"
        view.action = UIAction { [weak self] _ in
            self?.delegate?.precosDoLivroView(self!, selecionouTipo: .combo)
        }
        return view
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            precoEbookView,
            SeparadorView(),
            precoImpressoView,
            SeparadorView(),
            precoComboView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: .zero, bottom: 16, right: .zero)
        stackView.backgroundColor = .rum
        return stackView
    }()
    
    private lazy var observacaoLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "*Você terá acesso às futuras correções do livro."
        return label
    }()
    
    private lazy var atualizacoesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            observacaoLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            contentContainerStackView,
            atualizacoesStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    weak var delegate: PrecosDoLivroViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }
            
            livro.precos.forEach { preco in
                switch preco.tipoDeLivro {
                case .ebook:
                    precoEbookView.valor = preco.valor
                case .impresso:
                    precoImpressoView.valor = preco.valor
                case .combo:
                    precoComboView.valor = preco.valor
                }
            }
        }
    }
    
}

extension PrecosDoLivroView: ViewCode {
        
    func addSubviews() {
        addSubview(containerView)
    }
    
    func addLayoutConstraints() {
        containerView.constrainTo(edgesOf: self)
    }
    
}
