//
//  FavoritesListViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 11.12.2022.
//

import UIKit

protocol FavoritesListViewModelProtocol {
    var delegate: FavoriteListViewModelDelegate? {get set}
    func getFavoriteGameCount() -> Int
    func getFavoriteGames()
    func getGameFromFavorites(at index: Int) -> Game?
    func deleteGame(at index: Int)
    
}


protocol FavoriteListViewModelDelegate: AnyObject {
    func favoriteGamesChanged()
    
}
class FavoritesListViewModel: FavoritesListViewModelProtocol {
   
    
    weak var delegate: FavoriteListViewModelDelegate?
    private var games: [Game]?
    
    func getFavoriteGameCount() -> Int {
        games?.count ?? 0
    }
    
    func getFavoriteGames() {
        self.games = CoreDataManager.shared.fetchGames()
        self.delegate?.favoriteGamesChanged()
    }
    
    func getGameFromFavorites(at index: Int) -> Game? {
        games?[index]
    }
    
    func deleteGame(at index: Int) {
        guard let game = self.getGameFromFavorites(at: index) else {return}
        CoreDataManager.shared.deleteGame(game: game)
        games?.remove(at: index)
    }
    
    func getNotification(controller: UIViewController){
        NotificationCenter.default.addObserver(self, selector: #selector(handleButton), name: NSNotification.Name("buttonPressedNotification"), object: nil)
    }
    @objc func handleButton(_ notification: Notification){
        if let text = notification.object as? String {
            print(text)
        }
        self.delegate?.favoriteGamesChanged()
    }
}
