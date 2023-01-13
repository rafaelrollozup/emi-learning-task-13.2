//
//  OfertaDePrecoView.swift
//  LearningTask-13.2
//
//

import UIKit

class OfertaDePrecoView: UIView {
    
    private lazy var precoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var valorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            precoLabel,
            valorLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var callToActionButton: UIButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 16, weight: .bold)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("COMPRAR", attributes: container)
        configuration.baseForegroundColor = .pampas
        configuration.baseBackgroundColor = .saffronMango
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            labelsStackView, callToActionButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var margins: UIEdgeInsets? {
        didSet {
            guard let margins = margins else { return }
            containerStackView.layoutMargins = margins
        }
    }
    
    var titulo: String? {
        didSet {
            precoLabel.text = titulo
        }
    }
    
    var valor: Decimal? {
        didSet {
            guard let valor = valor else { return }
            valorLabel.text = NumberFormatter.formatToCurrency(decimal: valor)
        }
    }
    
    var action: UIAction? {
        didSet {
            guard let action = action else { return }
            callToActionButton.addAction(action, for: .touchUpInside)
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

extension OfertaDePrecoView: ViewCode {
    
    func addSubviews() {
        addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(edgesOf: self)
    }
    
}
