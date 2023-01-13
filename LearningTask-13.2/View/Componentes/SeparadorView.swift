//
//  SeparadorView.swift
//  LearningTask-13.2
//
//

import UIKit

class SeparadorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SeparadorView: ViewCode {
    
    func customizeAppearance() {
        backgroundColor = .quaternaryLabel
    }
    
    func addLayoutConstraints() {
        self.constrainHeight(to: 0.7)
    }
    
}
