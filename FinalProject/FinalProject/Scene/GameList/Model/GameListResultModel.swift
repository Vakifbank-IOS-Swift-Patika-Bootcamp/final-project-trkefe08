//
//  GameListResultModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import Foundation

struct GameListResultModel: Codable {
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratingsCount, reviewsTextCount, added: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String
    let reviewsCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
    }
}
