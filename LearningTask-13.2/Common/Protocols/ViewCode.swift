//
//  ViewCode.swift
//  LearningTask-13.2
//
//

import Foundation

protocol ViewCode {
    func customizeAppearance()
    func addSubviews()
    func addLayoutConstraints()
}

extension ViewCode {
    
    /// Orchestrates the ViewCode component configuration.
    /// A template method that performs a set of operations in a predefined sequence using the
    /// implementations provided by the class that conforms to the ViewCode protocol.
    ///
    func setup() {
        customizeAppearance()
        addSubviews()
        addLayoutConstraints()
    }
    
    func customizeAppearance() {
        // Nothing happens. Just to unenforce an implementation if you don't need one.
    }
    
    func addSubviews() {
        // Nothing happens. Just to unenforce an implementation if you don't need one.
    }
    
    func addLayoutConstraints() {
        // Nothing happens. Just to unenforce an implementation if you don't need one.
    }
    
}
