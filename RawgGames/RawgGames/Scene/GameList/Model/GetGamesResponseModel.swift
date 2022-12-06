//
//  GetGamesResponseModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import Foundation


// MARK: - GetGamesResponseModel
struct GetGamesResponseModel: Codable {
    let count: Int
    let next: String
    let results: [GameModel]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let gameDescription: String
    let filters: Filters
    let nofollowCollections: [String]

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gameDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}



// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYear]
    let nofollow: Bool
    let count: Int
}



// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int
    let nofollow: Bool
}
