//
//  TestViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 14.12.2022.
//

import UIKit

class TestViewController: UIViewController, UICollectionViewDataSource {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        viewModel.fetchGamesFromSameSeries(id: 3498)
    }
    private var viewModel = GameDetailViewModel()

    @IBOutlet weak var testcollection: UICollectionView!{
        didSet{
            testcollection.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getSimilarGamesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = testcollection.dequeueReusableCell(withReuseIdentifier: "moreGamesCell", for: indexPath) as? MoreGamesCollectionViewCell,
              let game = viewModel.getSimilarGame(at: indexPath.row) else {return UICollectionViewCell()}
        //cell.configureCell(game: game)
        return cell
    }
    
    

}

extension TestViewController: GameDetailViewModelDelegate {
    func gameLoaded(isFavorite: Bool) {
        
    }
    
    func similarGamesLoaded() {
        self.testcollection.reloadData()
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
