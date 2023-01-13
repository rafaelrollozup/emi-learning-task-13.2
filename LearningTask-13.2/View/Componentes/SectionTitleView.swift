//
//  SectionTitleView.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class SectionTitleView: UIView {
    
    static let alturaBase: CGFloat = 48
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.texasRose.withAlphaComponent(0.75).cgColor
        return layer
    }()
    
    var texto: String? {
        didSet {
            tituloLabel.text = texto
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
    }

}

extension SectionTitleView: ViewCode {
    
    func customizeAppearance() {
        backgroundColor = .white
        layer.insertSublayer(backgroundLayer, below: tituloLabel.layer)
    }
    
    func addSubviews() {
        addSubview(tituloLabel)
    }
    
    func addLayoutConstraints() {
        self.constrainHeight(greaterThanOrEqualTo: Self.alturaBase)
        
        tituloLabel.constrainToBottomAndSides(of: self,
                                              bottomMargin: 8,
                                              horizontalMargins: 20)
    }
    
}
