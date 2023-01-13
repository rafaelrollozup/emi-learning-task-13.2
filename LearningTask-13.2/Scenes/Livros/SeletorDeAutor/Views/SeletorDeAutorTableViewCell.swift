//
//  SeletorDeAutorTableViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import UIKit

class SeletorDeAutorTableViewCell: UITableViewCell {

    private lazy var radioImageView: UIImageView = {
        let image = UIImage(systemName: "circle")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .texasRose
        imageView.constrainSize(to: .init(width: 32, height: 32))
        return imageView
    }()
    
    private lazy var autorLabel: UILabel = {
        let label = UILabel.Span()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            radioImageView, autorLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    var autor: Autor? {
        didSet {
            guard let autor = autor else { return }
            
            autorLabel.text = autor.nomeCompleto
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        radioImageView.image = UIImage(systemName: "circle")
    }
    
    func markAsSelected(completionHandler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.radioImageView.alpha = 0
            self?.layoutIfNeeded()
            
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0.1, animations: { [weak self] in
                self?.radioImageView.image = UIImage(systemName: "circle.inset.filled")
                
                self?.radioImageView.alpha = 1
                self?.layoutIfNeeded()
            }) { _ in
                completionHandler()
            }
        }
    }
    
}

extension SeletorDeAutorTableViewCell: ReusableView {}

extension SeletorDeAutorTableViewCell: ViewCode {
    
    func customizeAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(contentContainerStackView)
    }
    
    func addLayoutConstraints() {
        contentContainerStackView.constrainTo(edgesOf: self)
    }
    
}
