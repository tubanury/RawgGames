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
    func addToFavorites(image: UIImage?)
    func prepareImageForSavingCoreData(image: UIImage?)
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
    func sendNotification()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    

    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    let userNotificationCenter =  UNUserNotificationCenter.current()
    
    let imageProcessingQueue = DispatchQueue(label: "imageProcessingQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    func fetchGameDetail(id: Int) {
        GameClient.getGameDetail(gameId: id) { [weak self] gameDetail, error in
            guard let self = self else {return}
            self.game = gameDetail
            self.delegate?.gameLoaded()
        }
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
    
    func addToFavorites(image: UIImage?){
        prepareImageForSavingCoreData(image: image)
    }
    
    func prepareImageForSavingCoreData(image: UIImage?) {
        if let image = image {
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                return
            }
        guard let game = CoreDataManager.shared.saveGame(img: imageData) else {return}
        let text = "save button"
        NotificationCenter.default.post(name: NSNotification.Name("buttonPressedNotification"), object: text)
        self.delegate?.sendNotification()
      }
        
    }
}
