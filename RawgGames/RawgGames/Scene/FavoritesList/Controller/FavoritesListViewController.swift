//
//  FavoritesListViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 11.12.2022.
//

import UIKit

class FavoritesListViewController: UIViewController {

    @IBOutlet weak var favoritesListTableView: UITableView!{
        didSet {
            favoritesListTableView.delegate = self
            favoritesListTableView.dataSource = self
        }
    }
    
    private var viewModel = FavoritesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getFavoriteGames()
        viewModel.getNotification(controller: self)
        /*NotificationCenter.default.addObserver(self, selector: #selector(handleButton), name: NSNotification.Name("buttonPressedNotification"), object: nil)*/
    }
    /*@objc func handleButton(_ notification: Notification){
        if let text = notification.object as? String {
            print(text)
        }
        self.delegate?.favoriteGamesChanged()
    }*/
}
extension FavoritesListViewController: FavoriteListViewModelDelegate {
    func favoriteGamesChanged() {
        favoritesListTableView.reloadData()
    }
}
extension FavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFavoriteGameCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteGameCell") as? FavoritesListTableViewCell,
              let game = viewModel.getGameFromFavorites(at: indexPath.row) else {return UITableViewCell()}
        cell.configureCell(game: game)
        cell.favoriteBtn = { [unowned self] in
            viewModel.deleteGame(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
