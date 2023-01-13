//
//  CarrinhoViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class CarrinhoViewController: UIViewController {
    
    private lazy var produtosTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemDeCompraTableViewCell.self, forCellReuseIdentifier: ItemDeCompraTableViewCell.reuseId)
        tableView.register(CarrinhoSectionHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: CarrinhoSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = CarrinhoSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .pampas
        return tableView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.constrainHeight(to: 44)
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            produtosTableView,
            footerStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var carrinho: Carrinho!
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        atualizaViews(com: carrinho)
    }
    
    private func atualizaViews(com carrinho: Carrinho) {
        produtosTableView.reloadData()
        totalLabel.text = NumberFormatter.formatToCurrency(decimal: carrinho.total)
    }

}

extension CarrinhoViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .rum
    }
    
    func addSubviews() {
        view.addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(safeEdgesOf: self.view)
    }
    
}

extension CarrinhoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrinho.itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: "ItemDeCompraTableViewCell", for: indexPath) as? ItemDeCompraTableViewCell else {
            fatalError("Não foi possível obter célula para o item de compra do carrinho")
        }
        
        celula.itemDeCompra = carrinho.itens[indexPath.row]
        return celula
    }

}

extension CarrinhoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarrinhoSectionHeaderView.reuseId) as? CarrinhoSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de itens de compra do carrinho")
        }
        
        headerView.titulo = "Seu carrinho de compras"
        return headerView
    }
    
}

