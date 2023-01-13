//
//  LivroViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var livroHeaderView: LivroHeaderView = {
        let view = LivroHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var precosView: PrecosDoLivroView = {
        let view = PrecosDoLivroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var detalhesDoLivroView: DetalhesDoLivroView = {
        let view = DetalhesDoLivroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        var margins = UIEdgeInsets.zero
        margins.bottom = 32
        
        let stackView = UIStackView(arrangedSubviews: [
            livroHeaderView,
            precosView,
            detalhesDoLivroView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = margins
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentContainerStackView)
        return scrollView
    }()
    
    var livro: Livro!
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        atualizaView(com: livro)
    }

    func atualizaView(com livro: Livro) {
        livroHeaderView.livro = livro
        precosView.livro = livro
        detalhesDoLivroView.livro = livro
    }
    
    func navegaParaCarrinho(com livro: Livro, doTipo tipoDeLivro: TipoDeLivro) {
        let carrinho = Carrinho.constroi(com: livro, doTipo: tipoDeLivro)
        
        let controller = CarrinhoViewController()
        controller.carrinho = carrinho
        
        navigationController?.present(controller, animated: true)
    }
    
}

extension LivroViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .pampas
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
    }
    
    func addLayoutConstraints() {
        scrollView.constrainTo(safeEdgesOf: view)
        
        contentContainerStackView.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = contentContainerStackView.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow
        
        contentContainerStackView.anchorToCenterX(of: scrollView)
        let centerYConstraint =  contentContainerStackView.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
    }
    
}

extension LivroViewController: PrecosDoLivroViewDelegate {
    
    func precosDoLivroView(_ view: PrecosDoLivroView, selecionouTipo tipoDeLivro: TipoDeLivro) {
        navegaParaCarrinho(com: livro, doTipo: tipoDeLivro)
    }
    
}
