//
//  String+Extension.swift
//  FinalProject
//
//  Created by Tarik Efe on 16.12.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
