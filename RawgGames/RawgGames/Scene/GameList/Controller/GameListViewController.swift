//
//  ViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit

class GameListViewController: BaseViewController {
    
    lazy var search = UISearchController(searchResultsController: nil)
    private var picker  = UIPickerView()
    private var toolBar = UIToolbar()
    var pickerValues = [Localizables.highestRating.value, Localizables.mostReviewed.value]
    private var noConnectionView = PlaceHolderView()

    
    @IBOutlet weak var sortButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var gameListTableView: UITableView!{
        didSet {
            gameListTableView.delegate = self
            gameListTableView.dataSource = self
            gameListTableView.prefetchDataSource = self
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
        LocalNotificationManager.shared.requestNotificationAuthorization()
        gameListTableView.refreshControl = UIRefreshControl()
        gameListTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    private func configureView(){
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
    
    private func configurePickerView(){
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
    private func addPlaceHolderView(){
        noConnectionView.translatesAutoresizingMaskIntoConstraints =  false
        noConnectionView.loadDataView(imageName: "noConnection", labelText: Localizables.noConnection.value)
        view.addSubview(noConnectionView)
        
        NSLayoutConstraint.activate([
            noConnectionView.topAnchor.constraint(equalTo: view.topAnchor, constant:50),
            noConnectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noConnectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noConnectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @IBAction func didSortButtonTapped(_ sender: Any) {
        configurePickerView()
    
    }
    @objc func didPullToRefresh(){
        viewModel.fetchGames()
    }
    
    @objc func onPickerSelectButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        sortList(by: picker.selectedRow(inComponent: 0))
    }
    
    private func sortList(by: Int) {
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
        presentAlert(title: Localizables.error.value, message: Localizables.gameNotFound.value)
    }
    func gamesSorted() {
        gameListTableView.reloadData()
        indicator.stopAnimating()
    }
    func noConnection() {
        addPlaceHolderView()
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{

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
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //todo
        /*for indexPath in indexPaths {
            guard let id = viewModel.getGame(at: indexPath.row)?.id else {return}
            guard let imageString = viewModel.getGame(at: indexPath.row)?.backgroundImage else {return}
            CacheManager.shared.getImage(id: id, imageString: imageString) { image in
                //nothing
            }
        }*/
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

