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
    func getGameName() ->String
    func prepareImageForSavingCoreData(image: UIImage?)
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    
    let imageProcessingQueue = DispatchQueue(label: "imageProcessingQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    func fetchGameDetail(id: Int) {
        GameClient.getGameDetail(gameId: id) { [weak self] gameDetail, error in
            guard let self = self else {return}
            self.game = gameDetail
            self.delegate?.gameLoaded()
        }
    }
    
    func getGameImageURL() -> URL? {
        URL(string: game?.backgroundImage ?? "")
    }
    
    func getGameName() -> String {
        game?.name ?? ""
    }
    
    func prepareImageForSavingCoreData(image: UIImage?) {
        imageProcessingQueue.async() {
            if let image = image {
                guard let imageData = image.jpegData(compressionQuality: 1) else {
                    //todo:  handle failed conversion
                    return
                }
                CoreDataManager.shared.saveGame(img: imageData)
            }
            let text = "save button"
            NotificationCenter.default.post(name: NSNotification.Name("buttonPressedNotification"), object: text)
        }
    }
    

}
