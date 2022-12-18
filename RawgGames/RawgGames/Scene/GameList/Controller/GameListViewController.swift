//
//  ViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit

class GameListViewController: BaseViewController {
    
    lazy var search = UISearchController(searchResultsController: nil)
    var picker  = UIPickerView()
    var toolBar = UIToolbar()
    var pickerValues = [Localizables.highestRating.value, Localizables.mostReviewed.value]
    
    @IBOutlet weak var sortButtonItem: UIBarButtonItem!
    
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
    
    func setupMenu() {
        let add = UIAction(title: "", image: UIImage(systemName: "plus")) { (action) in
            print("Add")
        }
        let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil")) { (action) in
            print("Edit")
        }
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "minus"), attributes: .destructive) { (action) in
            print("Delete")
        }
     
        let menu = UIMenu(children: [add, edit, delete])
        sortButtonItem.menu = menu
    }
    
    func configureView(){
        //setupMenu()
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
    
    @IBAction func didSortButtonTapped(_ sender: Any) {
        picker = UIPickerView.init()
           picker.delegate = self
           picker.dataSource = self
           picker.backgroundColor = UIColor.white
           picker.setValue(UIColor.black, forKey: "textColor")
           picker.autoresizingMask = .flexibleWidth
           picker.contentMode = .center
           picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
           self.view.addSubview(picker)
                   
           toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolBar.items = [UIBarButtonItem.init(title: "Select", style: .done, target: self, action: #selector(onPickerSelectButtonTapped))]
           self.view.addSubview(toolBar)
    
    }
    @objc func didPullToRefresh(){
        viewModel.fetchGames()
    }
    
    @objc func onPickerSelectButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        sortList(by: picker.selectedRow(inComponent: 0))
    }
    
    func sortList(by: Int) {
        viewModel.sortGames(by: by)
    }
}

extension GameListViewController: GameListViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        indicator.stopAnimating()
        self.gameListTableView.refreshControl?.endRefreshing()
    }
    func gamesFailed() {
        presentAlert(title: "Hata", message: "Oyunlar yüklenemedi")
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getGameCount()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell
        cell = nil
           if cell == nil {
               cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell
        }
       // guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell,
        guard let game = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        
        cell?.configureCell(game: game)
        return cell ?? UITableViewCell()
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

extension GameListViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }

}

