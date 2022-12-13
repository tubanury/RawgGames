//
//  ViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit

class GameListViewController: UIViewController {
    
    lazy var search = UISearchController(searchResultsController: nil)


    @IBOutlet weak var gameListTableView: UITableView!{
        didSet {
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
        }
    }
    
    private var viewModel = GameListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.delegate = self
        viewModel.fetchGames()
        viewModel.requestNotificationAuthorization()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView(){
        
        //search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.tintColor = .white
        search.searchBar.placeholder = "search...".localized()
        search.searchBar.barTintColor = .white
        self.definesPresentationContext = true
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationItem.title = "Start Playing!"
       
        self.navigationItem.titleView?.tintColor = .white
       
        let appearance = UINavigationBarAppearance()
        UINavigationBar.appearance().tintColor = UIColor.white
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearance.backgroundColor = #colorLiteral(red: 1, green: 0.7009803653, blue: 0.0008152386872, alpha: 0.8632295116)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
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
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else {return}
        detailVC.gameId = viewModel.getGame(at: indexPath.row)?.id
        self.navigationController!.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        //detailVC.modalPresentationStyle = .overFullScreen
        //present(detailVC, animated: true)
    }
   
   
}


