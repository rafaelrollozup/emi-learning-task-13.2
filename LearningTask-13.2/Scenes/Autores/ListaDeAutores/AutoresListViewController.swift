//
//  AutoresListViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class AutoresListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .pampas
        tableView.register(AutorTableViewCell.self, forCellReuseIdentifier: AutorTableViewCell.reuseId)
        tableView.register(TableSectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()

    var autoresAPI: AutoresAPI?
    var livrosAPI: LivrosAPI?
    
    var autores: [Autor] = []
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        setupViews()
        
        carregaAutores()
    }
    
    func setupViews() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(navegaParaFormNovoAutor))
        buttonItem.tintColor = .white
        
        navigationItem.setRightBarButton(buttonItem, animated: true)
    }
    
    func carregaAutores() {
        autoresAPI?.listaTodos(completionHandler: { [weak self] result in
            switch result {
            case .success(let autores):
                self?.autores = autores
                self?.tableView.reloadData()

            case .failure(let erro):
                let mensagem = "Não foi possível carregar autores. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        })
    }

    func navegaParaDetalhes(de autor: Autor) {
        let controller = AutorViewController()
        controller.livrosAPI = livrosAPI
        controller.autor = autor
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func navegaParaFormNovoAutor() {
        let controller = NovoAutorViewController()
        controller.delegate = self
        controller.autoresAPI = autoresAPI
        
        present(controller, animated: true)
    }
    
}

// MARK: - View code conformance
extension AutoresListViewController: ViewCode {
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addLayoutConstraints() {
        tableView.constrainTo(edgesOf: self.view)
    }
    
}

// MARK: - NovoAutor delegation implementations
extension AutoresListViewController: NovoAutorViewControllerDelegate {
    func novoAutorViewController(_ controller: NovoAutorViewController, adicionou autor: Autor) {
        autores.append(autor)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource Implementations
extension AutoresListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutorTableViewCell", for: indexPath) as? AutorTableViewCell else {
            fatalError("Não foi possível obter celula para a lista de autores")
        }
        
        let autor = autores[indexPath.row]
        cell.autor = autor
        
        return cell
    }
    
    var lastIndexPath: IndexPath {
        return .init(row: autores.count - 1, section: .zero)
    }
    
}

// MARK: - UITableViewDelegate Implementations
extension AutoresListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let autor = autores[indexPath.row]
        navegaParaDetalhes(de: autor)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de autores.")
        }
        
        headerView.titulo = "Todos os Autores"
        return headerView
    }
    
}
