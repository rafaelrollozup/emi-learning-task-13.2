//
//  TableSectionHeaderView.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class TableSectionHeaderView: UITableViewHeaderFooterView {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
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

extension TableSectionHeaderView: ViewCode {
    
    func customizeAppearance() {
        contentView.backgroundColor = .texasRose.withAlphaComponent(0.75)
    }
    
    func addSubviews() {
        addSubview(sectionTitleView)
    }
    
    func addLayoutConstraints() {
        self.constrainHeight(to: Self.alturaBase)
        sectionTitleView.constrainTo(edgesOf: self)
    }
    
}
