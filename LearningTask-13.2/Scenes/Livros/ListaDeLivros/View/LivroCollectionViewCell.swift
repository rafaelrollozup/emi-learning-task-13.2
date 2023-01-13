//
//  LivroCollectionViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroCollectionViewCell: UICollectionViewCell {
    
    private lazy var capaImageView: CapaImageView = {
        let imageView = CapaImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            capaImageView,
            tituloLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private var firstRender: Bool = true
   
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }

            capaImageView.setImageByDowloading(url: livro.imagemDeCapaURI,
                                               placeholderImage: .init(named: "Book"),
                                               animated: firstRender)
            tituloLabel.text = livro.titulo
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        firstRender = false
    }
}

extension LivroCollectionViewCell: ReusableView {}

extension LivroCollectionViewCell: ViewCode {
    
    func addSubviews() {
        addSubview(contentContainerStackView)
    }
    
    func addLayoutConstraints() {
        contentContainerStackView.constrainTo(edgesOf: self)
    }
    
}
