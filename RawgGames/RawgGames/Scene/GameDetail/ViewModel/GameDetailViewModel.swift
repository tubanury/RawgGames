//
//  GameDetailViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import Foundation
import UIKit


protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? {get set}
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameIconImageUrl() -> URL?
    func getGameName() -> String
    func getGameGenres() -> String
    func getGameRating() -> Double
    func getGameReviewCount() -> Int
    func getGameReleaseYear() -> String
    func getGameDeveloperName() -> String
    func getGameAddedCount() -> Int
    func getGameDescription() -> String
    func getSimilarGames() -> [GameModel]?
    func getSimilarGame(at index: Int) -> GameModel?
    func getSimilarGamesCount() -> Int
    func addToFavorites(image: UIImage?) -> Bool
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
    func similarGamesLoaded()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {

    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    private var similarGames: [GameModel]?
    
    
    func fetchGameDetail(id: Int) {
        GameClient.getGameDetail(gameId: id) { [weak self] gameDetail, error in
            guard let self = self else {return}
            self.game = gameDetail
            self.delegate?.gameLoaded()
        }
    }
    func fetchGamesFromSameSeries(id: Int) {
        GameClient.getGamesFromSameSeries(gameId: id) { [weak self] similar, error in
            guard let self = self else {return}
            self.similarGames = similar
            self.delegate?.similarGamesLoaded()
        }
    }
   
    func isGameFavorited() -> Bool{
        return CoreDataManager.shared.isGameSaved(id: game?.id ?? 0).count > 0
    }
    func getGameImageURL() -> URL? {
        URL(string: game?.backgroundImageAdditional ?? "")
    }
    func getGameIconImageUrl() -> URL? {
        URL(string: game?.backgroundImage ?? "")
    }
    
    func getGameName() -> String {
        game?.name ?? ""
    }
    
    
    func getGameGenres() -> String {
        var genres = ""
        for i in 0 ..< (game?.genres.count ?? 0) {
            genres += (game?.genres[i].name ?? "")
            if i != (game?.genres.count)!-1 {
                genres += ", "
            }
        }
        return genres
    }
    
    func getGameRating() -> Double {
        game?.rating ?? 0
    }
    
    func getGameReviewCount() -> Int {
        game?.reviewsCount ?? 0
    }
    
    func getGameReleaseYear() -> String {
        game?.released.components(separatedBy: "-").first ?? Localizables.unknown.value
    }
    
    func getGameDeveloperName() -> String {
        game?.developers.first?.name.components(separatedBy: " ").first ?? Localizables.unknown.value
    }
    
    func getGameAddedCount() -> Int {
        game?.added ?? 0
    }
    func getGameDescription() -> String {
        game?.descriptionRaw ?? Localizables.noDescription.value
    }
    
    func getSimilarGames() -> [GameModel]? {
        similarGames ?? []
    }
    
    func getSimilarGame(at index: Int) -> GameModel? {
        similarGames?[index]
    }
    func getSimilarGamesCount() -> Int {
        similarGames?.count ?? 0
    }

    func addToFavorites(image: UIImage?) -> Bool{
        guard let game else {return false}
        if CoreDataManager.shared.isGameSaved(id: game.id).count > 0{
            CoreDataManager.shared.deleteGame(game: CoreDataManager.shared.isGameSaved(id: game.id).first!)
            NotificationCenter.default.post(name: NSNotification.Name("buttonPressedNotification"), object: "save button")
            return false
        }
        else {
            let imageData = prepareImageForSavingCoreData(image: image)
            guard CoreDataManager.shared.saveGame(id: game.id , name: game.name , tag: game.tags.first?.name ?? "", img: imageData) != nil else {return false}
           
            NotificationCenter.default.post(name: NSNotification.Name("buttonPressedNotification"), object: "save button")
            LocalNotificationManager.shared.sendNotification(title: Localizables.favoritesNotificationTitle.value, body: Localizables.favoritesNotificationBody.value)
            return true
        }
    }
    
    private func prepareImageForSavingCoreData(image: UIImage?) -> Data {
        if let image = image {
            if let imageData = image.jpegData(compressionQuality: 1) {
                return imageData
            }
        }
        return Data()
    }
}
