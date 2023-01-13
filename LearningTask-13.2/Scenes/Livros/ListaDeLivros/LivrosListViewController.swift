//
//  LivrosListViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivrosListViewController: UIViewController {

    // MARK: - Subviews
    private static var layout: UICollectionViewFlowLayout {
        let baseItemSize = CGSize(width: 180, height: 302)
        let baseHeaderSize = CGSize(width: .zero, height: 48)
        let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = baseItemSize
        layout.headerReferenceSize = baseHeaderSize
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 24
        layout.sectionInset = sectionInsets
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LivrosListViewController.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LivroCollectionViewCell.self, forCellWithReuseIdentifier: LivroCollectionViewCell.reuseId)
        collectionView.register(LivroSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LivroSectionHeaderView.reuseId)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = .pampas
        return collectionView
    }()

    // MARK: - Properties
    var livrosAPI: LivrosAPI?
    var autoresAPI: AutoresAPI?
    
    var livros: [Livro] = []
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        setupViews()
        
        carregaLivros()
    }
    
    func setupViews() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(navegaParaFormNovoAutor))
        buttonItem.tintColor = .white
        
        navigationItem.setRightBarButton(buttonItem, animated: true)
    }
    
    func carregaLivros() {
        livrosAPI?.carregaTodos() { [weak self] result in
            switch result {
            case .success(let livros):
                self?.livros = livros
                self?.collectionView.reloadData()
                
            case .failure(let erro):
                let mensagem = "Não foi possível carregar livros. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        }
    }
    
    func navegaParaDetalhes(de livro: Livro) {
        let controller = LivroViewController()
        controller.livro = livro
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func navegaParaFormNovoAutor() {
        let controller = NovoLivroViewController()
        controller.delegate = self
        controller.autoresAPI = autoresAPI
        controller.livrosAPI = livrosAPI
        
        navigationController?.present(controller, animated: true)
    }

}

// MARK: - ViewCode setup implementations
extension LivrosListViewController: ViewCode {
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func addLayoutConstraints() {
        collectionView.constrainTo(edgesOf: self.view)
    }
    
}

// MARK: - NovoLivroViewController delegate implementations
extension LivrosListViewController: NovoLivroViewControllerDelegate {
    
    func novoLivroViewController(_ controller: NovoLivroViewController, adicionouLivro novoLivro: Livro) {
        livros.append(novoLivro)
        let index = IndexPath(row: livros.count - 1, section: .zero)
        
        collectionView.insertItems(at: [index])
        collectionView.scrollToItem(at: index, at: .bottom, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource implementations
extension LivrosListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return livros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let celula = collectionView.dequeueReusableCell(withReuseIdentifier: LivroCollectionViewCell.reuseId, for: indexPath) as? LivroCollectionViewCell else {
            fatalError("Não foi possível obter célula para o item na coleção de livros")
        }
        
        celula.livro = livros[indexPath.row]
        return celula
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return configureReusableHeaderView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
            
        default:
            fatalError("Tipo de view não suportado")
        }
    }
    
    func configureReusableHeaderView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LivroSectionHeaderView.reuseId, for: indexPath) as? LivroSectionHeaderView else {
            fatalError("Não foi possível recuperar view para o titulo da seção")
        }
        
        headerView.titulo = "Todos os Livros"
        return headerView
    }
    
}

// MARK: - UICollectionViewDelegate implementations
extension LivrosListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let livro = livros[indexPath.row]
        navegaParaDetalhes(de: livro)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout implementations
extension LivrosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("É esperado que a collectionView de livros trabalhe com layout baseado em FlowLayout.")
        }
      
        let margens = flowLayout.sectionInset
        let espacamento = flowLayout.minimumInteritemSpacing
        
        let itensPorLinha: CGFloat = 2
        let alturaDoLabel: CGFloat = 48
        
        let areaUtil = collectionView.bounds.width - ( margens.left + margens.right ) - espacamento * ( itensPorLinha - 1 )
        
        let largura = areaUtil / itensPorLinha
        let altura = largura * 1.41 + alturaDoLabel
        
        return CGSize(width: largura, height: altura)
    }
    
}

