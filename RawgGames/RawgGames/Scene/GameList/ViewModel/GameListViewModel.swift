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

final class GameListViewModel: GameListViewModelProtocol {
    
    weak var delegate: GameListViewModelDelegate?
    private var games: [GameModel]?
    let userNotificationCenter = UNUserNotificationCenter.current()

    func fetchGames() {
        self.games?.removeAll()
        GameClient.getGames { [weak self] games, error in
            guard let self = self else {return}
            if let _ =  error {
                //self.delegate?.gamesFailed()
            }
            self.games = games
            self.delegate?.gamesLoaded()
        }
    }
    
    func fetchGamesBySearchText(searchText: String){
        GameClient.getGamesBySearchText(searchText: searchText) { [weak self] searchGames, error in
            guard let self = self else {return}
            if let _ =  error {
                //self.delegate?.gamesFailed()
            }
            self.games = searchGames
            self.delegate?.gamesLoaded()
        }
        
    }
    
    func sortGames(by: Int) {
        switch by{
        case 0:
            self.games = games?.sorted() { $0.rating > $1.rating }
        case 1:
            self.games = games?.sorted() { $0.ratingsCount > $1.ratingsCount }
        default:
            self.games = games?.sorted() { $0.ratingsCount > $1.ratingsCount }
        }
        self.delegate?.gamesLoaded()
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
