//
//  NovaTecnologiaViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

protocol NovaTecnologiaViewControllerDelegate: AnyObject {
    func novaTecnologiaViewController(_ controller: NovaTecnologiaViewController, adicionou tecnologia: String)
}

class NovaTecnologiaViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var tituloLabel: UILabel = {
        let label = UILabel.SecondaryTitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Qual o nome da tecnologia?"
        return label
    }()
    
    private lazy var tecnologiaTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "tecnologia", aplicando: [
            .naoVazio, .min(length: 2)
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Código, agile ou qualquer outra coisa no meio"
        validador.adiciona(field)
        return field
    }()
    
    private lazy var bordaInferiorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .quaternaryLabel
        view.constrainHeight(to: 0.7)
        return view
    }()
    
    private lazy var tecnologiasInputView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tecnologiaTextField,
            bordaInferiorView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel,
            tecnologiasInputView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var adicionarButton: UIButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .regular)
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("Adicionar", attributes: container)
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = .texasRose
        configuration.baseForegroundColor = .white
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(botaoAdicionarPressionado(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            adicionarButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            formStackView,
            footerStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 42, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    // MARK: - Properties
    private var validador = Validador()
    
    weak var delegate: NovaTecnologiaViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func botaoAdicionarPressionado(_ sender: UIButton) {
        guard validador.estadoEhValido() else {
            UIAlertController.showError(validador.mensagemPadrao!, in: self)
            return
        }
    
        adicionaTecnologia()
    }
    
    func adicionaTecnologia() {
        let tecnologia = tecnologiaTextField.text!
        
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.novaTecnologiaViewController(self!, adicionou: tecnologia)
        }
    }
    
}

extension NovaTecnologiaViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .pampas
    }
    
    func addSubviews() {
        view.addSubview(containerStackView)
    }
    
    func addLayoutConstraints() {
        containerStackView.constrainTo(safeEdgesOf: self.view)
    }
    
}
