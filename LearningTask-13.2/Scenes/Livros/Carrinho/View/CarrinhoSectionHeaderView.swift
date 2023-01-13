//
//  CarrinhoSectionHeaderView.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class CarrinhoSectionHeaderView: UITableViewHeaderFooterView {
    
    static var alturaBase: CGFloat {
        return SectionTitleView.alturaBase
    }
    
    private lazy var sectionTitleView: SectionTitleView = {
        let view = SectionTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titulo: String? {
        didSet {
            sectionTitleView.texto = titulo
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CarrinhoSectionHeaderView: ReusableView {}

extension CarrinhoSectionHeaderView: ViewCode {
    
    func customizeAppearance() {
        contentView.backgroundColor = .texasRose.withAlphaComponent(0.75)
    }
    
    func addSubviews() {
        addSubview(sectionTitleView)
    }
    
    func addLayoutConstraints() {
        sectionTitleView.constrainTo(edgesOf: self)
    }
    
}
