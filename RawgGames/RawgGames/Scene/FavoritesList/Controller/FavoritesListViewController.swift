//
//  FavoritesListViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 11.12.2022.
//

import UIKit
import CoreData

class FavoritesListViewController: BaseViewController {

    @IBOutlet weak var favoritesListTableView: UITableView!{
        didSet {
            favoritesListTableView.delegate = self
            favoritesListTableView.dataSource = self
        }
    }
    
    private var viewModel = FavoritesListViewModel()
    private var beforeSearchImage = PlaceHolderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getFavoriteGames()
        viewModel.getNotification(controller: self)
    }
    
     private func addPlaceHolderView(){
         beforeSearchImage.translatesAutoresizingMaskIntoConstraints =  false
         view.addSubview(beforeSearchImage)
         
         NSLayoutConstraint.activate([
             beforeSearchImage.topAnchor.constraint(equalTo: view.topAnchor, constant:50),
             beforeSearchImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             beforeSearchImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             beforeSearchImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }

}
extension FavoritesListViewController: FavoriteListViewModelDelegate {
    func favoriteGamesChanged() {
        if viewModel.getFavoriteGameCount() > 0 {
            beforeSearchImage.removeFromSuperview()
            self.favoritesListTableView.reloadData()
        }
        else {
            addPlaceHolderView()
        }
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
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else {return}
        detailVC.gameId = Int(truncatingIfNeeded: viewModel.getGameFromFavorites(at: indexPath.row)?.id ?? 0)
        self.navigationController!.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
