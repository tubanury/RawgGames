//
//  GamesFromSameSeriesModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 14.12.2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gamesFromSameSeriesModel = try? newJSONDecoder().decode(GamesFromSameSeriesModel.self, from: jsonData)

import Foundation

// MARK: - FilteredGamesModel
struct FilteredGamesModel: Decodable {
    let count: Int
    //let next, previous: JSONNull?
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let metacritic: Int?
    let playtime, suggestionsCount: Int
    let updated: String
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let genres: [Genre]
    let tags: [Genre]
    let shortScreenshots: [ShortScreenshot]

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case genres, tags
        case shortScreenshots = "short_screenshots"
    }
}
/*
// MARK: - Platform
struct Platform: Codable {
    let platform: Genre
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
*/
