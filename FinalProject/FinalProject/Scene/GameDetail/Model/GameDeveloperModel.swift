//
//  GameDeveloperModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 11.12.2022.
//

import Foundation

struct GameDeveloperModel: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}
