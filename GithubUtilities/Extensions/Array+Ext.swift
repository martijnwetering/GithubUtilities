//
//  Array+Ext.swift
//  GithubUtilities
//
//  Created by Martijn van de Wetering on 29/01/2024.
//

import Foundation

extension Array where Element: Equatable {
    mutating func update(with array: [Element]) {
        for item in array {
            if !self.contains(item) {
                self.insert(item, at: 0)
            }
        }
    }
}
