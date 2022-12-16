// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gamesFromSearchModel = try? newJSONDecoder().decode(GamesFromSearchModel.self, from: jsonData)

import Foundation

// MARK: - GamesFromSearchModel
struct GamesFromSearchModel: Codable {
    let count: Int
    let next: String
    let results: [GameModel]
    let userPlatforms: Bool

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case userPlatforms = "user_platforms"
    }
}

