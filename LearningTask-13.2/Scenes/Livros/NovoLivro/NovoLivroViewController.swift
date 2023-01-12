//
//  NovoLivroViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import UIKit

protocol NovoLivroViewControllerDelegate: AnyObject {
    func novoLivroViewController(_ controller: NovoLivroViewController,
                                 adicionouLivro novoLivro: Livro)
}

class NovoLivroViewController: UIViewController {
    
    typealias MensagemDeValidacao = String

    @IBOutlet private weak var capaImageView: UIImageView!
    @IBOutlet private weak var capaTextField: UITextField!
    
    @IBOutlet private weak var tituloTextField: UITextField!
    @IBOutlet private weak var subtituloTextField: UITextField!
    @IBOutlet private weak var autorTextField: UITextField!
    
    @IBOutlet private weak var descricaoTextView: UITextView!
    
    @IBOutlet private weak var precoEbookTextField: UITextField!
    @IBOutlet private weak var precoImpressoTextField: UITextField!
    @IBOutlet private weak var precoComboTextField: UITextField!
    
    @IBOutlet private weak var numeroDePaginasTextField: UITextField!
    @IBOutlet private weak var isbnTextField: UITextField!
    @IBOutlet private weak var dataDePublicacaoTextField: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        capaImageView.layer.masksToBounds = true
        capaImageView.layer.cornerRadius = 4
        
        descricaoTextView.layer.masksToBounds = true
        descricaoTextView.layer.cornerRadius = 6
        descricaoTextView.layer.borderWidth = 1
        descricaoTextView.layer.borderColor = UIColor(white: 238/255, alpha: 1).cgColor
    }
    
    @IBAction func capaTextFieldEditingDidEnd(_ sender: UITextField) {
        guard let urlString = capaTextField.text,
              let fotoDeCapaURI = URL(string: urlString) else { return }
        
        capaImageView.setImageByDowloading(url: fotoDeCapaURI,
                                           placeholderImage: .init(named: "Book"),
                                           animated: true)
    }
    
    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        switch formularioEhValido() {

        case (false, let mensagem):
            UIAlertController.showError(mensagem!, in: self)

        default:
            cadastraLivro()
        }
    }
    
    private func formularioEhValido() -> (Bool, MensagemDeValidacao?) {
        guard let urlString = capaTextField.text,
              let _ = URL(string: urlString) else {
            return (false, "Informe uma URL válida para a foto de capa")
        }
        
        guard let titulo = tituloTextField.text, !titulo.isEmpty else {
            return (false, "Título não pode estar em branco")
        }
        
        guard let subtitulo = subtituloTextField.text, !subtitulo.isEmpty else {
            return (false, "Subtítulo não pode estar em branco")
        }
        
        guard autor != nil else {
            return (false, "Selecione um autor para o livro")
        }
        
        guard let descricao = descricaoTextView.text, !descricao.isEmpty else {
            return (false, "Descrição não pode estar em branco")
        }
        
        guard let precoEbookString = precoEbookTextField.text,
              let _ = Decimal(string: precoEbookString) else {
            return (false, "Informe um preço válido para o eBook deste título")
        }
        
        guard let precoImpressoString = precoImpressoTextField.text,
              let _ = Decimal(string: precoImpressoString) else {
            return (false, "Informe um preço válido para o impresso deste título")
        }
        
        guard let precoComboString = precoComboTextField.text,
              let _ = Decimal(string: precoComboString) else {
            return (false, "Informe um preço válido para o combo deste título")
        }
        
        guard let numeroDePaginasString = numeroDePaginasTextField.text,
                let _ = Int(numeroDePaginasString) else {
            return (false, "Informe um número de páginas válido")
        }
        
        guard let isbn = isbnTextField.text, !isbn.isEmpty else {
            return (false, "Informe o ISBN do livro")
        }
        
        guard let dataDePublicacaoString = dataDePublicacaoTextField.text,
              let _ = Date.from(dataDePublicacaoString, using: .dayMonthAndYear) else {
            return (false, "Informe uma data válida de publicação")
        }
        
        return (true, nil)
    }
    
    private func constroiLivro() -> Livro {
        let imagemDeCapaURI = URL(string: capaTextField.text!)!
        let precoEbook = Preco(valor: Decimal(string: precoEbookTextField.text!)!,
                               tipoDeLivro: .ebook)
        let precoImpresso = Preco(valor: Decimal(string: precoImpressoTextField.text!)!,
                                  tipoDeLivro: .impresso)
        let precoCombo = Preco(valor: Decimal(string: precoComboTextField.text!)!,
                               tipoDeLivro: .combo)
        let dataDePublicacao = Date.from(dataDePublicacaoTextField.text!,
                                         using: .dayMonthAndYear)!
        
        return Livro(titulo: tituloTextField.text!,
                     subtitulo: subtituloTextField.text!,
                     imagemDeCapaURI: imagemDeCapaURI,
                     autor: self.autor!,
                     precos: [precoEbook, precoImpresso, precoCombo],
                     descricao: descricaoTextView.text!,
                     numeroDePaginas: Int(numeroDePaginasTextField.text!)!,
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
                UIAlertController.showError(mensagem, in: self!) {
                    self?.dismiss(animated: true)
                }
            }
        }
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
    
        guard let seletorDeAutor = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SeletorDeAutorViewController.identifier) as? SeletorDeAutorViewController else {
            fatalError("Não foi possível instanciar controlador para seleção de autor")
        }
        
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
        textView.textColor = .label
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let descricao = textView.text, descricao.isEmpty else { return }
        textView.textColor = .secondaryLabel
        textView.text = Self.placeholder
    }
    
}
