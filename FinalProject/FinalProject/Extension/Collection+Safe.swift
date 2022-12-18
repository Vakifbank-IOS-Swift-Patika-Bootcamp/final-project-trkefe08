//
//  Collection+Safe.swift
//  FinalProject
//
//  Created by Tarik Efe on 14.12.2022.
//

import Foundation
public extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
