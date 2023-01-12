//
//  LivroViewController.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroViewController: UIViewController {

    @IBOutlet private weak var tituloLabel: UILabel!
    @IBOutlet private weak var subtituloLabel: UILabel!
    @IBOutlet private weak var nomeDoAutorLabel: UILabel!
    
    @IBOutlet private weak var capaImageView: UIImageView!
    
    @IBOutlet private weak var precoEbookLabel: UILabel!
    @IBOutlet private weak var precoImpressoLabel: UILabel!
    @IBOutlet private weak var precoComboLabel: UILabel!
    
    @IBOutlet private weak var descricaoLabel: UILabel!
    
    @IBOutlet private weak var fotoAutorLabel: UIImageView!
    @IBOutlet private weak var nomeAutorLabel: UILabel!
    @IBOutlet private weak var bioAutorLabel: UILabel!
    
    @IBOutlet private weak var paginasLabel: UILabel!
    @IBOutlet private weak var isbnLabel: UILabel!
    @IBOutlet private weak var dataLancamentoLabel: UILabel!
    
    var livro: Livro!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        // Do any additional setup after loading the view.
        
        atualizaView(com: livro)
    }

    func atualizaView(com livro: Livro) {
        tituloLabel.text = livro.titulo
        subtituloLabel.text = livro.subtitulo
        nomeDoAutorLabel.text = livro.autor.nomeCompleto
        capaImageView.setImageByDowloading(url: livro.imagemDeCapaURI,
                                           placeholderImage: .init(named: "Book"))
    
        livro.precos.forEach { preco in
            let valor = NumberFormatter.formatToCurrency(decimal: preco.valor)
            switch preco.tipoDeLivro {
            case .ebook:
                precoEbookLabel.text = valor
            case .impresso:
                precoImpressoLabel.text = valor
            case .combo:
                precoComboLabel.text = valor
            }
        }
        
        descricaoLabel.text = livro.descricao
        
        fotoAutorLabel.setImageByDowloading(url: livro.autor.fotoURI,
                                            placeholderImage: .init(named: "Avatar"))
        nomeAutorLabel.text = livro.autor.nomeCompleto
        bioAutorLabel.text = livro.autor.bio
        
        paginasLabel.text = String(describing: livro.numeroDePaginas)
        isbnLabel.text = livro.isbn
        dataLancamentoLabel.text = DateFormatter.format(date: livro.dataDePublicacao,
                                                        to: .dayMonthAndYear)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "abrirCarrinhoComLivroSegue" else { return }
        
        guard let botaoComprar = sender as? UIButton,
              let controller = segue.destination as? CarrinhoViewController else {
            fatalError("Não foi possível executar segue \(segue.identifier!)")
        }
        
        guard let tipoSelecionado = TipoDeLivro.allCases
            .filter({ $0.index == botaoComprar.tag }).first else {
            fatalError("Não foi possível determinar a opção de tipo de livro ao processar a segue \(segue.identifier!)")
        }
        
        controller.carrinho = Carrinho.constroi(com: livro, doTipo: tipoSelecionado)
    }
    
}

