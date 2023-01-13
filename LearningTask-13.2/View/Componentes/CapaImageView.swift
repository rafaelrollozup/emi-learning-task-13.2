//
//  CapaImageView.swift
//  LearningTask-13.2
//
//

import UIKit

class CapaImageView: UIImageView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CapaImageView: ViewCode {
    
    fileprivate static let ratio: Double = 42.5 / 60
    
    func customizeAppearance() {
        contentMode = .scaleAspectFit
    }
    
    func addLayoutConstraints() {
        constrainWidthProportionally(byApplying: Self.ratio)
    }
    
}
