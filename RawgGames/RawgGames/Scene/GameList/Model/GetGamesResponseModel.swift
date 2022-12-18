//
//  GetGamesResponseModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import Foundation


// MARK: - GetGamesResponseModel
struct GetGamesResponseModel: Decodable {
    let count: Int
    let results: [GameModel]

}

