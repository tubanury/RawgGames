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
    var coreDataQueue = DispatchQueue(label: "coreDataQueue")
    let imageProcessingQueue = DispatchQueue(label: "imageProcessingQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id  = gameId else {return}
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
    }

    @IBAction func didAddFavoriteButtonTapped(_ sender: Any) {
        
        prepareImageForSaving(image: gameImageView.image!)
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        gameNameLabel.text = viewModel.getGameName()
        guard let url = viewModel.getGameImageURL() else {return}
        gameImageView.af.setImage(withURL: url)
    }
}

extension GameDetailViewController {

    func prepareImageForSaving(image:UIImage) {

        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970

        // dispatch with gcd.
        imageProcessingQueue.async() {

            // create NSData from UIImage
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                // handle failed conversion
                print("jpg error")
                return
            }

    
            // send to save function
            CoreDataManager.shared.saveGame(img: imageData)

        }
    }
}
