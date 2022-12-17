//
//  ViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit

class GameListViewController: BaseViewController {
    
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
        search.searchBar.delegate = self
        indicator.startAnimating()
        viewModel.fetchGames()
        viewModel.requestNotificationAuthorization()
        gameListTableView.refreshControl = UIRefreshControl()
        gameListTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView(){
        
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.tintColor = .white
        search.searchBar.placeholder = Localizables.search.value
        search.searchBar.barTintColor = .white
        self.definesPresentationContext = true
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationItem.title = Localizables.browseGames.value
       
        self.navigationItem.titleView?.tintColor = .white
       
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearance.backgroundColor = #colorLiteral(red: 1, green: 0.7009803653, blue: 0.0008152386872, alpha: 0.8632295116)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    @objc func didPullToRefresh(){
        viewModel.fetchGames()
    }
    
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        indicator.stopAnimating()
        self.gameListTableView.refreshControl?.endRefreshing()

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
       
    }
}

extension GameListViewController: UISearchBarDelegate {    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = search.searchBar.text else {return}
        indicator.startAnimating()
        viewModel.fetchGamesBySearchText(searchText: text)
    }
}

