//
//  GameListModel.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import Foundation

struct GameListModel: Codable {
    let count: Int?
    let next: String?
    let results: [GameListResultModel]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let gameListModelDescription: String?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gameListModelDescription = "description"
        case nofollowCollections = "nofollow_collections"
    }
}
