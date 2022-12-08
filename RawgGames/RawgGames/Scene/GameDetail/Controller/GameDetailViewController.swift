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

}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        gameNameLabel.text = viewModel.getGameName()
        guard let url = viewModel.getGameImageURL() else {return}
        gameImageView.af.setImage(withURL: url)
    }
    
}
