//
//  Theme.swift
//  LearningTask-13.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

// MARK: - Application theme protocol
protocol ThemeConfigurable: UIViewController {
    func applyTheme()
}

// MARK: - Protocol extension to regular controllers
extension ThemeConfigurable {
    
    func applyTheme() {
        configureStatusBar()
        configureNavigationItem()
    }
    
    private func configureStatusBar() {
        navigationController?.setStatusBar(backgroundColor: .texasRose)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureNavigationItem() {
        let logoImageView = UIImageView(image: .init(named: "LogoTypo"))
        logoImageView.tintColor = .white
        logoImageView.contentMode = .scaleAspectFit
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 176, height: 44))
        logoImageView.frame = titleView.bounds
        titleView.addSubview(logoImageView)
        
        navigationItem.titleView = titleView
    }
    
}

// MARK: - Theme protocol conformance
extension UIViewController: ThemeConfigurable {}

// MARK: - Protocol extension to navigation controllers
extension ThemeConfigurable where Self == UINavigationController {

    func applyTheme() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .texasRose
        self.navigationBar.backgroundColor = .texasRose
        self.navigationBar.tintColor = .white
    }
 
    init(with rootViewController: UIViewController, thematic: Bool = false) {
        self.init(rootViewController: rootViewController)
        if thematic { applyTheme() }
    }
}

// MARK: - Protocol extension to tab bar controller
extension ThemeConfigurable where Self == UITabBarController {
    
    func applyTheme() {
        let font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.secondaryLabel
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .texasRose
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.texasRose
        ]
        
        if #available(iOS 15.0, *) {
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        self.tabBar.standardAppearance = appearance
        
        self.tabBar.layer.shadowPath = UIBezierPath(rect: self.tabBar.bounds).cgPath
        self.tabBar.layer.shadowRadius = 8.0
        self.tabBar.layer.shadowOpacity = 0.3
        self.tabBar.layer.shadowColor = UIColor.secondaryLabel.cgColor
        self.tabBar.layer.shadowOffset = .init(width: 0, height: -5)
    }
    
    init(with viewControllers: [UIViewController], thematic: Bool = false) {
        self.init()
        self.viewControllers = viewControllers
        
        if thematic { applyTheme() }
    }
}

// MARK: - UINavigationController API customization
extension UINavigationController {
    fileprivate func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        
        view.addSubview(statusBarView)
    }
}

// MARK: - UIColor extension to provide branding color
extension UIColor {
    static var texasRose: UIColor = .init(named: "Texas Rose") ?? .systemOrange
    static var pampas: UIColor = .init(named: "Pampas") ?? .tertiarySystemBackground
    static var rum: UIColor = .init(named: "Rum") ?? .secondarySystemBackground
    static var saffronMango: UIColor = .init(named: "Saffron Mango") ?? .systemYellow
}

// MARK: - UILabel extension to provide branding typography
private protocol Stylable: UILabel {
    var styles: CustomStyles { get }
    func apply(_ styles: CustomStyles)
}

extension Stylable {
    func apply(_ styles: CustomStyles) {
        self.textColor = styles.textColor
        self.font = styles.font
        self.textAlignment = styles.textAlignment
        self.numberOfLines = styles.numberOfLines
    }
}

extension UILabel {
    
    struct CustomStyles {
        let textColor: UIColor
        let font: UIFont
        let textAlignment: NSTextAlignment
        let numberOfLines: Int
    }
    
    class Title: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 26, weight: .semibold),
            textAlignment: .left,
            numberOfLines: 0
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class SecondaryTitle: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 22, weight: .semibold),
            textAlignment: .left,
            numberOfLines: 0
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class TertiaryTitle: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 18, weight: .semibold),
            textAlignment: .left,
            numberOfLines: 0
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class Subtitle: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 22, weight: .light),
            textAlignment: .left,
            numberOfLines: 0
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class Emphasize: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .secondaryLabel,
            font: .systemFont(ofSize: 18, weight: .light),
            textAlignment: .left,
            numberOfLines: 1
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class Span: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .secondaryLabel,
            font: .systemFont(ofSize: 16, weight: .light),
            textAlignment: .left,
            numberOfLines: 1
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }
    
    class Strong: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 16, weight: .bold),
            textAlignment: .left,
            numberOfLines: 1
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }

    class Paragraph: UILabel, Stylable {
        var styles: UILabel.CustomStyles = .init(
            textColor: .label,
            font: .systemFont(ofSize: 14, weight: .light),
            textAlignment: .left,
            numberOfLines: 0
        )
        
        convenience init() {
            self.init(frame: .zero)
            apply(styles)
        }
    }

}
