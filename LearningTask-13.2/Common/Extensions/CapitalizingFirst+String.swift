//
//  CapitalizingFirst+String.swift
//  LearningTask-13.2
//
//

import Foundation

extension String {
    
    func capitalizingFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}
