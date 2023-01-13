//
//  AutorTableViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class AutorTableViewCell: UITableViewCell {

    private lazy var nomeLabel: UILabel = {
        let label = UILabel.Emphasize()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    private lazy var tecnologiasLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var titulosStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nomeLabel,
            tecnologiasLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var iconeImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.forward")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        imageView.constrainSize(to: .init(width: 24, height: 24))
        return imageView
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titulosStackView,
            iconeImageView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()

    var autor: Autor? {
        didSet {
            guard let autor = autor else { return }

            nomeLabel.text = autor.nomeCompleto
            tecnologiasLabel.text = autor.tecnologias.joined(separator: ", ")
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

extension AutorTableViewCell: ReusableView {}

extension AutorTableViewCell: ViewCode {
    
    func customizeAppearance() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = .texasRose.withAlphaComponent(0.3)
        selectedBackgroundView = bgColorView
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(contentContainerStackView)
    }
    
    func addLayoutConstraints() {
        contentContainerStackView.constrainTo(edgesOf: self)
    }
    
}
