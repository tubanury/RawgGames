//
//  ViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit

class GameListViewController: UIViewController {

   
    @IBOutlet weak var gameListTableView: UITableView!{
        didSet {
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
        }
    }
    
    private var viewModel = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

    
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getGameCount()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell,
              let game = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        
        cell.configureCell(game: game)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
   
}


