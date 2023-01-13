//
//  LivroSectionHeaderView.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroSectionHeaderView: UICollectionReusableView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LivroSectionHeaderView: ReusableView {}

extension LivroSectionHeaderView: ViewCode {
    
    func addSubviews() {
        addSubview(sectionTitleView)
    }
    
    func addLayoutConstraints() {
        sectionTitleView.constrainTo(edgesOf: self)
    }
    
}
