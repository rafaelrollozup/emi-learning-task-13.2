//
//  Navigation.swift
//  LearningTask-13.2
//
//

import UIKit

// MARK: - Factory protocol
protocol ControllerFactory: AnyObject {
    func constroi() -> UIViewController
}

// MARK: - Factory para fluxo de navegação de livros
class LivrosNavigation: ControllerFactory {
    
    var livrosAPI: LivrosAPI
    var autoresAPI: AutoresAPI
    
    init(livrosAPI: LivrosAPI, autoresAPI: AutoresAPI) {
        self.livrosAPI = livrosAPI
        self.autoresAPI = autoresAPI
    }
    
    func constroi() -> UIViewController {
        let rootViewController = LivrosListViewController()
        rootViewController.livrosAPI = livrosAPI
        rootViewController.autoresAPI = autoresAPI
        
        return UINavigationController(with: rootViewController, thematic: true)
    }
}

// MARK: - Factory para fluxo de navegação de autores
class AutoresNavigation: ControllerFactory {

    var livrosAPI: LivrosAPI
    var autoresAPI: AutoresAPI
    
    init(livrosAPI: LivrosAPI, autoresAPI: AutoresAPI) {
        self.livrosAPI = livrosAPI
        self.autoresAPI = autoresAPI
    }
    
    func constroi() -> UIViewController {
        let rootViewController = AutoresListViewController()
        rootViewController.autoresAPI = autoresAPI
        rootViewController.livrosAPI = livrosAPI
 
        return UINavigationController(with: rootViewController, thematic: true)
    }
}

// MARK: - Factory para o controlador de tabs da aplicação

enum Tab {
    case livros
    case autores

    var item: UITabBarItem {
        switch self {
        case .livros:
            return UITabBarItem(title: "Livros",
                                image: UIImage(systemName: "book.closed"),
                                selectedImage: UIImage(systemName: "book.closed.fill"))

        case .autores:
            return UITabBarItem(title: "Autores",
                                image: UIImage(systemName: "person.3"),
                                selectedImage: UIImage(systemName: "person.3.fill"))
        }
    }
    
}

class ApplicationTabBar: ControllerFactory {
    typealias TabContext = KeyValuePairs<Tab, any ControllerFactory>
    
    var tabs: TabContext
    
    init(tabs: TabContext) {
        self.tabs = tabs
    }
    
    func constroi() -> UIViewController {
        let viewControllers = tabs.enumerated().map { (index, entry) in
            let (tab, factory) = entry
            
            let tabItem = tab.item
            tabItem.tag = index
            
            let controller = factory.constroi()
            controller.tabBarItem = tabItem
            
            return controller
        }
        
        return UITabBarController(with: viewControllers, thematic: true)
    }
}
