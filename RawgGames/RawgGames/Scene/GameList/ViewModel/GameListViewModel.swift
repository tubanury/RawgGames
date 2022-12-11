//
//  GameListViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import Foundation
import UserNotifications

protocol GameListViewModelProtocol {
    var delegate: GameListViewModelDelegate? {get set}
    func fetchGames()
    func getGameCount() -> Int
    func getGame(at index: Int) -> GameModel?
    func requestNotificationAuthorization()
}

protocol GameListViewModelDelegate: AnyObject {
    func gamesLoaded()
    //func gamesFailed()
}

class GameListViewModel: GameListViewModelProtocol {
    
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameModel]?
    let userNotificationCenter = UNUserNotificationCenter.current()

    func fetchGames() {
        GameClient.getGames { [weak self] games, error in
            guard let self = self else {return}
            if let _ =  error {
                //self.delegate?.gamesFailed()
            }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    func getGameCount() -> Int {
        games?.count ?? 0
    }
    func getGame(at index: Int) -> GameModel? {
        return games?[index]
    }
    
     func requestNotificationAuthorization(){
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { _, error in
            if let error = error {
                //todo: handle error
            }
            //self.delegate?.sendNotification()
        }
    }
   
}
