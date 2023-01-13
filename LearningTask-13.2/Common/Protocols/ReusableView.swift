//
//  ReusableView.swift
//  LearningTask-13.2
//
//

import UIKit

protocol ReusableView: UIView {
    static var reuseId: String { get }
}

extension ReusableView {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
