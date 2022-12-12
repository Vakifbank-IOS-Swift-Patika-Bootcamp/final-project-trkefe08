//
//  GameDetailModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 11.12.2022.
//

import Foundation

struct GameDetailModel: Codable {
    let id: Int?
    let slug, name, nameOriginal, gameDetailModelDescription: String?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop: Int?
    let added: Int?
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int?
    let ratingsCount: Int?
    let reviewsCount: Int?
    let developers, genres, tags, publishers: [GameDeveloperModel]?
    let descriptionRaw: String?
    let metacriticPlatforms: [MetaModel]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case metacriticPlatforms = "metacritic_platforms"
        case nameOriginal = "name_original"
        case gameDetailModelDescription = "description"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case added
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case ratingsCount = "ratings_count"
       
        case reviewsCount = "reviews_count"
        case developers, genres, tags, publishers
        case descriptionRaw = "description_raw"
    }
}
