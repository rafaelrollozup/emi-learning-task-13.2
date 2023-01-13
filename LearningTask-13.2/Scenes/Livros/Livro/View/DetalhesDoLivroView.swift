//
//  DetalhesDoLivroView.swift
//  LearningTask-13.2
//
//

import UIKit

class DetalhesDoLivroView: UIView {
    
    private lazy var conteudoLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var conteudoStackView: UIStackView = {
        let tituloLabel: UILabel = {
            let label = UILabel.SecondaryTitle()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Conteúdo"
            return label
        }()
        
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel,
            conteudoLabel,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var autorImageView: UIImageView = {
        let size = CGSize(width: 76, height: 76)
        let image = UIImage(named: "Avatar")
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.constrainSize(to: size)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size.width / 2
        return imageView
    }()
    
    private lazy var nomeDoAutorLabel: UILabel = {
        let label = UILabel.Subtitle()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bioDoAutorLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var autorStackView: UIStackView = {
        let tituloLabel: UILabel = {
            let label = UILabel.SecondaryTitle()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Autor"
            return label
        }()
        
        let headerStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [
                autorImageView, nomeDoAutorLabel,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 12
            return stackView
        }()
        
        let wrapperStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [
                headerStackView,
                bioDoAutorLabel,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 12
            return stackView
        }()
        
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel,
            wrapperStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var numeroDePaginalLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var isbnLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dataDePublicacaoLabel: UILabel = {
        let label = UILabel.Paragraph()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dadosDeProdutoStackView: UIStackView = {
        let tituloLabel: UILabel = {
            let label = UILabel.SecondaryTitle()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Dados do Produto"
            return label
        }()
        
       let paginasStackView: UIStackView = {
           let tituloLabel: UILabel = {
               let label = UILabel()
               label.translatesAutoresizingMaskIntoConstraints = false
               label.text = "Número de Páginas"
               label.font = .systemFont(ofSize: 14, weight: .semibold)
               return label
           }()
           
           let stackView = UIStackView(arrangedSubviews: [
                tituloLabel,
                numeroDePaginalLabel,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 4
            return stackView
        }()
        
        let isbnStackView: UIStackView = {
            let tituloLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "ISBN"
                label.font = .systemFont(ofSize: 14, weight: .semibold)
                return label
            }()
            
            let stackView = UIStackView(arrangedSubviews: [
                 tituloLabel,
                 isbnLabel,
             ])
             stackView.translatesAutoresizingMaskIntoConstraints = false
             stackView.axis = .horizontal
             stackView.alignment = .fill
             stackView.distribution = .fill
             stackView.spacing = 4
             return stackView
         }()
        
        let dataDePublicacaoStackView: UIStackView = {
            let tituloLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "Data de Publicação"
                label.font = .systemFont(ofSize: 14, weight: .semibold)
                return label
            }()
            
            let stackView = UIStackView(arrangedSubviews: [
                 tituloLabel,
                 dataDePublicacaoLabel,
             ])
             stackView.translatesAutoresizingMaskIntoConstraints = false
             stackView.axis = .horizontal
             stackView.alignment = .fill
             stackView.distribution = .fill
             stackView.spacing = 4
             return stackView
         }()
        
        let wrapperStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [
                paginasStackView,
                isbnStackView,
                dataDePublicacaoStackView,
            ])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 4
            return stackView
        }()
        
        let stackView = UIStackView(arrangedSubviews: [
            tituloLabel,
            wrapperStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            conteudoStackView,
            autorStackView,
            dadosDeProdutoStackView,
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 20, bottom: 12, right: 20)
        return stackView
    }()
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }
            
            conteudoLabel.text = livro.descricao
            
            autorImageView.setImageByDowloading(url: livro.autor.fotoURI)
            nomeDoAutorLabel.text = livro.autor.nomeCompleto
            bioDoAutorLabel.text = livro.autor.bio
    
            numeroDePaginalLabel.text = String(describing: livro.numeroDePaginas)
            isbnLabel.text = livro.isbn
            dataDePublicacaoLabel.text = DateFormatter.format(date: livro.dataDePublicacao, to: .dayMonthAndYear)
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

extension DetalhesDoLivroView: ViewCode {
    
    func addSubviews() {
        addSubview(containerView)
    }
    
    func addLayoutConstraints() {
        containerView.constrainTo(edgesOf: self)
    }
    
}
