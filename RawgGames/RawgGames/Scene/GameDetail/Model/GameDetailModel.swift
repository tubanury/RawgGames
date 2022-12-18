//
//  GameDetailModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import Foundation


// MARK: - GameDetailModel
struct GameDetailModel: Decodable {
    let id: Int
    let slug, name, nameOriginal, gameDetailModelDescription: String
    let metacritic: Int
    let released: String
    let backgroundImage, backgroundImageAdditional: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let added: Int
    let reviewsTextCount: Int
    let ratingsCount, suggestionsCount: Int
    let parentsCount, additionsCount, gameSeriesCount: Int
    let reviewsCount: Int
    let developers, genres, tags, publishers: [Developer]
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case gameDetailModelDescription = "description"
        case metacritic
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case rating
        case ratingTop = "rating_top"
        case ratings, added
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case developers, genres, tags, publishers
        case descriptionRaw = "description_raw"
    }
}



// MARK: - Developer
struct Developer: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}
