//
//  LivroDoAutorTableViewCell.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroDoAutorTableViewCell: UITableViewCell {

    static var alturaBase: CGFloat {
        return 96.5
    }
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel.Span()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var capaImageView: CapaImageView = {
        let imageView = CapaImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constrainWidth(to: 142)
        return imageView
    }()
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }

            tituloLabel.text = livro.titulo
            capaImageView.setImageByDowloading(url: livro.imagemDeCapaURI,
                                               placeholderImage: .init(named: "Book"),
                                               animated: true)
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

extension LivroDoAutorTableViewCell: ReusableView {}

extension LivroDoAutorTableViewCell: ViewCode {
    
    func customizeAppearance() {
        clipsToBounds = true

        let bgColorView = UIView()
        bgColorView.backgroundColor = .texasRose.withAlphaComponent(0.3)
        selectedBackgroundView = bgColorView
        backgroundColor = .pampas
    }
    
    func addSubviews() {
        addSubview(tituloLabel)
        addSubview(capaImageView)
    }
    
    func addLayoutConstraints() {
        self.constrainHeight(to: Self.alturaBase)
        
        tituloLabel.constrainToTop(of: self, withMargin: 16)
        tituloLabel.constrainToLeading(of: self, withMargin: 20)
        
        capaImageView.constrainToTop(of: tituloLabel)
        capaImageView.anchorOn(trailingOf: tituloLabel, withMargin: 20)
        capaImageView.constrainToTrailing(of: self, withMargin: 20)
        capaImageView.constrainToBottom(of: self, withMargin: -120)
    }
    
}
