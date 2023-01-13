//
//  NovoAutorViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

protocol NovoAutorViewControllerDelegate: AnyObject {
    func novoAutorViewController(_ controller: NovoAutorViewController, adicionou autor: Autor)
}

class NovoAutorViewController: UIViewController {
    
    // MARK: - Subviews
    private lazy var logoWrapperStackView: UIStackView = {
        let imageView = UIImageView(image: .init(named: "LogoTypo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.constrainHeight(to: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.constrainHeight(to: 48)
        stackView.backgroundColor = .texasRose.withAlphaComponent(0.75)
        return stackView
    }()
    
    private lazy var fotoImageView: UIImageView = {
        let image = UIImage(named: "Avatar")
        let size = CGSize(width: 100, height: 100)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.constrainSize(to: size)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size.width / 2
        return imageView
    }()
    
    private lazy var fotoWrapperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fotoImageView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var fotoTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "foto do autor", aplicando: [
            .naoVazio, .urlValida
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "https://domain.com/photos/photo.png"
        field.borderStyle = .roundedRect
        field.addTarget(self, action: #selector(fotoTextFieldEditingDidEnd(_:)), for: .editingDidEnd)
        validador.adiciona(field)
        return field
    }()
    
    private lazy var fotoInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Foto:"
        inputView.input = fotoTextField
        return inputView
    }()
    
    private lazy var nomeTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "nome", aplicando: [
            .naoVazio, .min(length: 5), .nomeCompletoValido
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Autor do Livro"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var nomeInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Nome:"
        inputView.input = nomeTextField
        return inputView
    }()
    
    private lazy var bioTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "bio do autor", aplicando: [.naoVazio, .min(length: 140)])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Descrição do autor em poucas palavras"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var bioInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Bio:"
        inputView.input = bioTextField
        return inputView
    }()
    
    private lazy var tecnologiasTableView: TecnologiasTableView = {
        let tableView = TecnologiasTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(TecnologiaViewCell.self, forCellReuseIdentifier: TecnologiaViewCell.reuseId)
        tableView.adicionarAction = UIAction { [weak self] _ in
            self?.navegaParaFormNovaTecnologia()
        }
        return tableView
    }()
    
    private lazy var tecnologiasStackView: UIStackView = {
        let label: UILabel = {
            let label = UILabel.Span()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Tecnologias:"
            return label
        }()
        
        let stackView = UIStackView(arrangedSubviews: [
            label,
            tecnologiasTableView,
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
            fotoInputView,
            nomeInputView,
            bioInputView,
            tecnologiasStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var submitButton: UIButton = {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14, weight: .bold)

        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("Adicionar Autor", attributes: container)
        configuration.baseBackgroundColor = .texasRose
        configuration.cornerStyle = .capsule

        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(botaoSalvarPressionado(_:)), for: .touchUpInside)
        button.constrainHeight(to: 48)
        return button
    }()
    
    private lazy var contentContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fotoWrapperStackView,
            formStackView,
            submitButton,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    private lazy var containerStackView: UIStackView = {
        var margins = UIEdgeInsets.zero
        margins.bottom = 32
        
        let stackView = UIStackView(arrangedSubviews: [
            logoWrapperStackView,
            contentContainerStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = margins
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerStackView)
        return scrollView
    }()
    
    // MARK: - Properties
    private var validador = Validador()
    
    var autoresAPI: AutoresAPI?
    
    weak var delegate: NovoAutorViewControllerDelegate?
    
    var tecnologias: [String] = []
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc func fotoTextFieldEditingDidEnd(_ sender: UITextField) {
        guard let urlString = sender.text, let url = URL(string: urlString) else {
            return
        }
        
        fotoImageView.setImageByDowloading(url: url,
                                           placeholderImage: .init(named: "Avatar"),
                                           animated: true)
    }
    
    @objc func botaoSalvarPressionado(_ sender: UIButton) {
        guard validador.estadoEhValido() else {
            UIAlertController.showError(validador.mensagemPadrao!, in: self)
            return
        }
        
        if tecnologias.isEmpty {
            let mensagem = "Adicione ao menos uma tecnologia sobre a qual o(a) autor(a) escreve."
            UIAlertController.showError(mensagem, in: self)
            
            return
        }

        cadastraAutor()
    }
    
    private func separa(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
    
    func cadastraAutor() {
        let (nome, sobrenome) = separa(nomeDeAutor: nomeTextField.text!)
        let autor = Autor(foto: URL(string: fotoTextField.text!)!,
                          nome: nome,
                          sobrenome: sobrenome,
                          bio: bioTextField.text!,
                          tecnologias: tecnologias)

        autoresAPI?.registraNovo(autor) { [weak self] result in
            switch result {
            case .success(let novoAutor):
                self?.dismiss(animated: true) {
                    self?.delegate?.novoAutorViewController(self!, adicionou: novoAutor)
                }

            case .failure(let erro):
                let mensagem = "Não foi possível adicionar autor. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        }
    }
    
    func navegaParaFormNovaTecnologia() {
        let controller = NovaTecnologiaViewController()
        controller.delegate = self
        
        present(controller, animated: true)
    }

}

// MARK: - View code conformance
extension NovoAutorViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .pampas
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
    }
    
    func addLayoutConstraints() {
        scrollView.constrainTo(edgesOf: self.view)
        
        containerStackView.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = containerStackView.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow
        
        containerStackView.anchorToCenterX(of: scrollView)
        let centerYConstraint =  containerStackView.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
    }
    
}

// MARK: - Handles NovaTecnologiaViewController delegation
extension NovoAutorViewController: NovaTecnologiaViewControllerDelegate {
   
    func novaTecnologiaViewController(_ controller: NovaTecnologiaViewController, adicionou tecnologia: String) {
        tecnologias.append(tecnologia)
        
        let path = IndexPath(row: tecnologias.count - 1, section: .zero)
        tecnologiasTableView.insertRows(at: [path], with: .automatic)
    }
    
}

// MARK: - TableView Data Source implementations
extension NovoAutorViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tecnologias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: TecnologiaViewCell.reuseId, for: indexPath) as? TecnologiaViewCell else {
            fatalError("Não foi possível obter célula para a tecnologia do autor em NovoAutor")
        }
        
        celula.tecnologia = tecnologias[indexPath.row]
        return celula
    }
    
}
