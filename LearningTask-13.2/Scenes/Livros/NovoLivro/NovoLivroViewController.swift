//
//  NovoLivroViewController.swift
//  LearningTask-13.2
//
//

import UIKit

protocol NovoLivroViewControllerDelegate: AnyObject {
    func novoLivroViewController(_ controller: NovoLivroViewController,
                                 adicionouLivro novoLivro: Livro)
}

class NovoLivroViewController: UIViewController {
    
    typealias MensagemDeValidacao = String
    
    // MARK: - Subviews
    // Ah! forms 😵‍💫 to-do: fluxo de adição com UX aprimorada (sem o uso de formulários)
    
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
    
    private lazy var capaImageView: UIImageView = {
        let imageView = CapaImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Book")
        imageView.constrainHeight(to: 150)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private lazy var capaWrapperStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            capaImageView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var fotoDeCapaTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "foto de capa", aplicando: [
            .naoVazio, .urlValida
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "https://domain.com/photos/photo.png"
        field.borderStyle = .roundedRect
        field.addTarget(self, action: #selector(fotoDeCapaTextFieldEditingDidEnd(_:)), for: .editingDidEnd)
        validador.adiciona(field)
        return field
    }()
    
    private lazy var fotoDeCapaInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Foto de capa:"
        inputView.input = fotoDeCapaTextField
        return inputView
    }()
    
    private lazy var tituloTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "título", aplicando: [.naoVazio, .min(length: 5)])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Título do Livro"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var tituloInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Título:"
        inputView.input = tituloTextField
        return inputView
    }()
    
    private lazy var subtituloTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "subtítulo", aplicando: [.naoVazio, .min(length: 40)])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Subtítulo do Livro"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var subtituloInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Subtítulo:"
        inputView.input = subtituloTextField
        return inputView
    }()
    
    private lazy var autorTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "autor", aplicando: [
            .naoVazio, .min(length: 5), .nomeCompletoValido
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "Autor do Livro"
        field.borderStyle = .roundedRect
        field.clearButtonMode = .unlessEditing
        validador.adiciona(field)
        return field
    }()
    
    private lazy var autorInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Autor:"
        inputView.input = autorTextField
        return inputView
    }()
    
    private lazy var descricaoTextView: UITextView.Valida = {
        let view = UITextView.Valida(rotulo: "descrição", aplicando: [
            .naoVazio, .min(length: 280)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.textColor = .tertiaryLabel
        view.font = .systemFont(ofSize: 14)
        view.text = "Descrição do Livro"
        
        view.constrainHeight(to: 100)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.7
        view.layer.borderColor = UIColor(white: 232/255, alpha: 1).cgColor
        
        validador.adiciona(view)
        return view
    }()
    
    private lazy var descricaoInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Descrição:"
        inputView.input = descricaoTextView
        return inputView
    }()
    
    private lazy var precoEbookTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "preço do eBook", aplicando: [.naoVazio, .decimalValido])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "R$ 0,00"
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        validador.adiciona(field)
        return field
    }()
    
    private lazy var precoEbookInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Preço do eBook:"
        inputView.input = precoEbookTextField
        return inputView
    }()
    
    private lazy var precoImpressoTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "preço do impresso", aplicando: [.naoVazio, .decimalValido])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "R$ 0,00"
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        validador.adiciona(field)
        return field
    }()
    
    private lazy var precoImpressoInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Preço do impresso:"
        inputView.input = precoImpressoTextField
        return inputView
    }()
    
    private lazy var precoComboTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "preço de eBook + impresso", aplicando: [.naoVazio, .decimalValido])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "R$ 0,00"
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        validador.adiciona(field)
        return field
    }()
    
    private lazy var precoComboInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Preço do combo:"
        inputView.input = precoComboTextField
        return inputView
    }()
    
    private lazy var paginasTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "número de páginas", aplicando: [.naoVazio, .inteiroValido])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "123"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        validador.adiciona(field)
        return field
    }()
    
    private lazy var paginasInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Número de páginas:"
        inputView.input = paginasTextField
        return inputView
    }()
    
    private lazy var isbnTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "ISBN", aplicando: [.naoVazio])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "123-45-6789-012-34"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var isbnInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "ISBN:"
        inputView.input = isbnTextField
        return inputView
    }()
    
    private lazy var publicacaoTextField: UITextField.Valido = {
        let field = UITextField.Valido(rotulo: "data de publicação", aplicando: [
            .naoVazio, .dataValida(usando: .dayMonthAndYear)
        ])
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .secondaryLabel
        field.font = .systemFont(ofSize: 14)
        field.placeholder = "01/01/2000"
        field.borderStyle = .roundedRect
        validador.adiciona(field)
        return field
    }()
    
    private lazy var publicacaoInputView: InputView = {
        let inputView = InputView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.titulo = "Data de publicação:"
        inputView.input = publicacaoTextField
        return inputView
    }()
    
    private lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fotoDeCapaInputView,
            tituloInputView,
            subtituloInputView,
            autorInputView,
            descricaoInputView,
            precoEbookInputView,
            precoImpressoInputView,
            precoComboInputView,
            paginasInputView,
            isbnInputView,
            publicacaoInputView,
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
        configuration.attributedTitle = AttributedString("Adicionar Livro", attributes: container)
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
            capaWrapperStackView,
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
    var livrosAPI: LivrosAPI?
    
    weak var delegate: NovoLivroViewControllerDelegate?
    
    private var autor: Autor? {
        didSet {
            guard let autor = autor else { return }
            autorTextField.text = autor.nomeCompleto
            descricaoTextView.becomeFirstResponder()
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func fotoDeCapaTextFieldEditingDidEnd(_ sender: UITextField) {
        guard let urlString = fotoDeCapaTextField.text,
              let fotoDeCapaURI = URL(string: urlString) else { return }
        
        capaImageView.setImageByDowloading(url: fotoDeCapaURI,
                                           placeholderImage: .init(named: "Book"),
                                           animated: true)
    }
    
    @objc func botaoSalvarPressionado(_ sender: UIButton) {
        guard validador.estadoEhValido(),
              let _ = autor else {
            
            UIAlertController.showError(validador.mensagemPadrao!, in: self)
            return
        }

        cadastraLivro()
    }
        
    private func constroiLivro() -> Livro {
        let imagemDeCapaURI = URL(string: fotoDeCapaTextField.text!)!
        let precoEbook = Preco(valor: Decimal(string: precoEbookTextField.text!)!,
                               tipoDeLivro: .ebook)
        let precoImpresso = Preco(valor: Decimal(string: precoImpressoTextField.text!)!,
                                  tipoDeLivro: .impresso)
        let precoCombo = Preco(valor: Decimal(string: precoComboTextField.text!)!,
                               tipoDeLivro: .combo)
        let dataDePublicacao = Date.from(publicacaoTextField.text!,
                                         using: .dayMonthAndYear)!
        
        return Livro(titulo: tituloTextField.text!,
                     subtitulo: subtituloTextField.text!,
                     imagemDeCapaURI: imagemDeCapaURI,
                     autor: self.autor!,
                     precos: [precoEbook, precoImpresso, precoCombo],
                     descricao: descricaoTextView.text!,
                     numeroDePaginas: Int(paginasTextField.text!)!,
                     dataDePublicacao: dataDePublicacao,
                     isbn: isbnTextField.text!)
    }
    
    func cadastraLivro() {
        let livro = constroiLivro()
        
        livrosAPI?.registraNovo(livro) { [weak self] result in
            switch result {
            case .success(let novoLivro):
                self?.dismiss(animated: true) {
                    self?.delegate?.novoLivroViewController(self!, adicionouLivro: novoLivro)
                }
                
            case .failure(let erro):
                let mensagem = "Não foi possível adicionar novo livro. \(erro.localizedDescription)"
                UIAlertController.showError(mensagem, in: self!)
            }
        }
    }
    
}

// MARK: View Code
extension NovoLivroViewController: ViewCode {
    
    func customizeAppearance() {
        view.backgroundColor = .pampas
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
    }
    
    func addLayoutConstraints() {
        scrollView.constrainTo(safeEdgesOf: view)
        
        containerStackView.constrainToTopAndSides(of: scrollView)
        let bottomConstraint = containerStackView.constrainToBottom(of: scrollView)
        bottomConstraint.priority = .defaultLow
        
        containerStackView.anchorToCenterX(of: scrollView)
        let centerYConstraint =  containerStackView.anchorToCenterY(of: scrollView)
        centerYConstraint.priority = .defaultLow
    }
    
}

// MARK: - Handles SeletorDeAutor execution
extension NovoLivroViewController: SeletorDeAutorViewControllerDelegate {
 
    func seletorDeAutorViewController(_ controller: SeletorDeAutorViewController,
                                      selecionouAutor autorSelecionado: Autor) {
        autor = autorSelecionado
    }
    
}

// MARK: - Text Input Delegate implementation handles autor text input
extension NovoLivroViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let autor = textField.text, autor.isEmpty else { return }
    
        let seletorDeAutor = SeletorDeAutorViewController()
        seletorDeAutor.delegate = self
        seletorDeAutor.autoresAPI = autoresAPI
        
        present(seletorDeAutor, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// MARK: - Text View Delegate implementation handles descrição text view
extension NovoLivroViewController: UITextViewDelegate {
    
    private static let placeholder: String = "Descrição do Livro"
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let descricao = textView.text,
              descricao.elementsEqual(Self.placeholder) else { return }
        textView.textColor = .secondaryLabel
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let descricao = textView.text, descricao.isEmpty else { return }
        textView.textColor = .tertiaryLabel
        textView.text = Self.placeholder
    }
    
}
