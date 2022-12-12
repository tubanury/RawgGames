//
//  GameDetailViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import UIKit
import AlamofireImage

final class GameDetailViewController: UIViewController {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    var gameId: Int?
    
    private var viewModel = GameDetailViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id  = gameId else {return}
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
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
    }
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "RawgGames".localized(with: "App name")
        notificationContent.body = "Did you play your new fave games? Check it out!".localized()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "FavoritesNotification", content: notificationContent, trigger: trigger)
        
        viewModel.userNotificationCenter.add(request){ error in
            if let error = error {
                //todo: handle error
            }
        }
    }
    
}

