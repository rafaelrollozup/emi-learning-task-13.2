//
//  AutorViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class AutorViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(LivroDoAutorTableViewCell.self, forCellReuseIdentifier: LivroDoAutorTableViewCell.reuseId)
        tableView.rowHeight = LivroDoAutorTableViewCell.alturaBase
        tableView.register(TableSectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
        
        return tableView
    }()
    
    var livrosAPI: LivrosAPI?
    
    var autor: Autor!
    
    var livrosDoAutor: [Livro] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        setupViews()
        
        carregaLivrosDoAutor()
    }

    private func setupViews() {
        tableView.tableHeaderView = AutorTableHeaderView.constroi(para: autor)
    }
    
    private func carregaLivrosDoAutor() {
        guard let id = autor.id else { return }
        
        livrosAPI?.carregaLivros(porAutorId: id) { [weak self] result in
            switch result {
            case .success(let livros):
                self?.livrosDoAutor = livros
                
            case .failure(let erro):
                let mensagem = "Não foi possível carregar os livros do autor. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        }
    }
    
}

extension AutorViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addLayoutConstraints() {
        tableView.constrainTo(edgesOf: self.view)
    }
    
}

// MARK: - UITableViewDataSource Implementations
extension AutorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return livrosDoAutor.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LivroDoAutorTableViewCell.reuseId, for: indexPath) as? LivroDoAutorTableViewCell else {
            fatalError("Não foi possível recuperar célula para livro do autor")
        }
        
        cell.livro = livrosDoAutor[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate Implementations
extension AutorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível recuperar a view de header para a lista de livros do autor")
        }
        
        headerView.titulo = "Livros publicados"
        return headerView
    }
    
}
