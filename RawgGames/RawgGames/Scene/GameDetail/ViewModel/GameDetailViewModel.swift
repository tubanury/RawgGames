//
//  GameDetailViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import Foundation
import UIKit
import UserNotifications

typealias CompletionHandler = (_ success:Bool) -> Void

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
    func getSimilarGames() -> [Result]?
    func getSimilarGame(at index: Int) -> Result?
    func getSimilarGamesCount() -> Int
    func addToFavorites(image: UIImage?) -> Bool
    func prepareImageForSavingCoreData(image: UIImage?) -> Data
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded(isFavorite: Bool)
    func similarGamesLoaded()
    func sendNotification()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {

    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    private var similarGames: [Result]?
    let userNotificationCenter =  UNUserNotificationCenter.current()
    
    let imageProcessingQueue = DispatchQueue(label: "imageProcessingQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    func fetchGameDetail(id: Int) {
        GameClient.getGameDetail(gameId: id) { [weak self] gameDetail, error in
            guard let self = self else {return}
            self.game = gameDetail
            let isFave = CoreDataManager.shared.isGameSaved(id: id).count > 0
            self.delegate?.gameLoaded(isFavorite: isFave)
        }
    }
    func fetchGamesFromSameSeries(id: Int) {
        GameClient.getGamesFromSameSeries(gameId: id) { [weak self] similar, error in
            guard let self = self else {return}
            self.similarGames = similar
            self.delegate?.similarGamesLoaded()
        }
    }
    func fetchGamesFromSameDevelopers(){
        
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
        game?.released.components(separatedBy: "-").first ?? "Unknown"
    }
    
    func getGameDeveloperName() -> String {
        game?.developers.first?.name.components(separatedBy: " ").first ?? "Unknown"
    }
    
    func getGameAddedCount() -> Int {
        game?.added ?? 0
    }
    func getGameDescription() -> String {
        game?.descriptionRaw ?? "No Description"
    }
    
    func getSimilarGames() -> [Result]? {
        similarGames ?? []
    }
    
    func getSimilarGame(at index: Int) -> Result? {
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
            self.delegate?.sendNotification()
            return false
        }
        else {
            let imageData = prepareImageForSavingCoreData(image: image)
            guard CoreDataManager.shared.saveGame(id: game.id , name: game.name , tag: game.tags.first?.name ?? "", img: imageData) != nil else {return false}
           
            NotificationCenter.default.post(name: NSNotification.Name("buttonPressedNotification"), object: "save button")
            self.delegate?.sendNotification()
            return true
        }
    }
    
    func prepareImageForSavingCoreData(image: UIImage?) -> Data {
        if let image = image {
            if let imageData = image.jpegData(compressionQuality: 1) {
                return imageData
            }
        }
        return Data()
    }
}
