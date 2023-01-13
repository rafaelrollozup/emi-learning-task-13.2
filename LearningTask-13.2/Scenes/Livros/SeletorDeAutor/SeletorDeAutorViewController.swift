//
//  SeletorDeAutorViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import UIKit

protocol SeletorDeAutorViewControllerDelegate: AnyObject {
    func seletorDeAutorViewController(_ controller: SeletorDeAutorViewController,
                                      selecionouAutor autor: Autor)
}

class SeletorDeAutorViewController: UIViewController {

    // MARK: - Subviews
    private lazy var overlayActivityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.color = .texasRose
        view.startAnimating()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(SeletorDeAutorTableViewCell.self, forCellReuseIdentifier: SeletorDeAutorTableViewCell.reuseId)
        tableView.register(TableSectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
        tableView.alpha = 0
        return tableView
    }()
    
    var autoresAPI: AutoresAPI?
    
    weak var delegate: SeletorDeAutorViewControllerDelegate?
    
    var autores: [Autor] = [] {
        didSet {
            updateTableAnimating()
        }
    }
    
    private var autorSelecionado: Autor? {
        didSet {
            delegateCallback()
        }
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        
        carregaAutores()
    }
    
    func carregaAutores() {
        autoresAPI?.listaTodos() { [weak self] result in
            switch result {
            case .success(let autores):
                self?.autores = autores
                
            case .failure(let erro):
                let mensagem = "Não foi possível carregar autores. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        }
    }
    
    func updateTableAnimating() {
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.overlayActivityIndicator.alpha = 0
            self?.overlayActivityIndicator.stopAnimating()
            self?.overlayActivityIndicator.layoutIfNeeded()
            
        }) { _ in
            UIView.animate(withDuration: 0.7, delay: 0.2, animations: { [weak self] in
                self?.tableView.alpha = 1
                self?.tableView.layoutIfNeeded()
           })
        }
    }
    
    func delegateCallback() {
        guard let autorSelecionado = autorSelecionado else {
            preconditionFailure("Autor não selecionado ao executar delegate")
        }
        
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.seletorDeAutorViewController(self!, selecionouAutor: autorSelecionado)
        }
    }

}

// MARK: - View Code conformance
extension SeletorDeAutorViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .pampas
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(overlayActivityIndicator)
    }
    
    func addLayoutConstraints() {
        tableView.constrainTo(edgesOf: self.view)
        overlayActivityIndicator.anchorToCenter(of: self.view)
    }
}

// MARK: - TableView Data Source implementations
extension SeletorDeAutorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeletorDeAutorTableViewCell.reuseId, for: indexPath) as? SeletorDeAutorTableViewCell else {
            fatalError("Não foi possível recuperar célula para a lista de seleção de autores")
        }
        
        cell.autor = autores[indexPath.row]
        return cell
    }
    
}

// MARK: - TableView delegation implementations
extension SeletorDeAutorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SeletorDeAutorTableViewCell else { return }
        
        selectedCell.markAsSelected { [weak self] in
            self?.autorSelecionado = self?.autores[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de autores.")
        }
        
        headerView.titulo = "Todos os Autores"
        return headerView
    }
    
}
