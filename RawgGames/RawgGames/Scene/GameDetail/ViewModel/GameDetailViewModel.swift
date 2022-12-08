//
//  GameDetailViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import Foundation


protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? {get set}
    func fetchGameDetail(id: Int)
    func getGameImageURL() -> URL?
    func getGameName() ->String
}

protocol GameDetailViewModelDelegate: AnyObject {
    func gameLoaded()
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    
    weak var delegate: GameDetailViewModelDelegate?
    private var game: GameDetailModel?
    
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
    
}
