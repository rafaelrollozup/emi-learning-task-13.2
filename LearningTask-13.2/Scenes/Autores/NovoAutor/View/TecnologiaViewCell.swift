//
//  TecnologiaViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class TecnologiaViewCell: UITableViewCell {

    private lazy var tituloLabel: UILabel = {
        let label = UILabel.Strong()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: .zero, left: 20, bottom: .zero, right: 20)
        stackView.backgroundColor = .rum
        stackView.layer.cornerRadius = 10
        stackView.constrainHeight(to: 42)
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        var margins = UIEdgeInsets.zero
        margins.bottom = 16
        
        let stackView = UIStackView(arrangedSubviews: [
            contentContainerStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = margins
        return stackView
    }()
    
    var tecnologia: String? {
        didSet {
            tituloLabel.text = tecnologia
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TecnologiaViewCell: ReusableView {}

extension TecnologiaViewCell: ViewCode {
    
    func customizeAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(edgesOf: self)
    }
    
}
