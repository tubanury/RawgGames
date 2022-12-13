//
//  GameDetailViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import UIKit
import AlamofireImage

final class GameDetailViewController: UIViewController {

    var gameId: Int?

    @IBOutlet weak var detailTagsCollectionView: UICollectionView! {
        didSet {
            //detailTagsCollectionView.delegate = self
            detailTagsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameIconImageView: UIImageView!
    @IBOutlet weak var gameGenresLabel: UILabel!
    
    private var viewModel = GameDetailViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       
        guard let id  = gameId else {return}
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func didTappedBackButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didAddFavoriteButtonTapped(_ sender: Any) {
        viewModel.addToFavorites(image: gameImageView.image)
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        gameNameLabel.text = viewModel.getGameName()
        guard let url = viewModel.getGameImageURL() else {return}
        gameImageView.af.setImage(withURL: url)
        if let iconUrl = viewModel.getGameIconImageUrl(){
            gameIconImageView.af.setImage(withURL: iconUrl)
        }
        gameGenresLabel.text = viewModel.getGameGenres()
        self.detailTagsCollectionView.reloadData()
    }
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Recently added new favorite games."
        notificationContent.body = "Did you play your new fave games? Check it out!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "FavoritesNotification", content: notificationContent, trigger: trigger)
        
        viewModel.userNotificationCenter.add(request){ error in
            if let error = error {
                //todo: handle error
            }
        }
    }
    
}

extension GameDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailTagCollectionViewCell", for: indexPath) as! DetailTagCollectionViewCell
        cell.setup(rating: viewModel.getGameRating(), ratingCount: viewModel.getGameReviewCount(), year: viewModel.getGameReleaseYear(), developer: viewModel.getGameDeveloperName(), added: viewModel.getGameAddedCount(), index: indexPath.row)
        return cell
    }
}

