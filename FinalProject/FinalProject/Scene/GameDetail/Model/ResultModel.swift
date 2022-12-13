//
//  ResultModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 13.12.2022.
//

import Foundation

struct ResultModel: Codable {
    let name: String?
    let backgroundImage: String?
}

enum CodingKeys: String, CodingKey {
    case name
    case backgroundImage = "background_image"
}
