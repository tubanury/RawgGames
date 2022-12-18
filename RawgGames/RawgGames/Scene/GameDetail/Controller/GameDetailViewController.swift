//
//  GameDetailViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 8.12.2022.
//

import UIKit
import AlamofireImage

final class GameDetailViewController: BaseViewController {

    var gameId: Int?

    @IBOutlet weak var detailTagsCollectionView: UICollectionView!{
        didSet {
            detailTagsCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var moreGamesCollectionView: UICollectionView! {
        didSet {
            moreGamesCollectionView.dataSource = self
            moreGamesCollectionView.delegate = self
        }
    }
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameIconImageView: UIImageView!
    @IBOutlet weak var gameGenresLabel: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var viewModel = GameDetailViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id  = gameId else {return}
        viewModel.delegate = self
        indicator.startAnimating()
        viewModel.fetchGamesFromSameSeries(id: id)
        viewModel.fetchGameDetail(id: id)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func didTappedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didAddFavoriteButtonTapped(_ sender: Any) {
        if viewModel.addToFavorites(image: gameIconImageView.image){
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        indicator.stopAnimating()
        gameNameLabel.text = viewModel.getGameName()
        guard let url = viewModel.getGameImageURL() else {return}
        gameImageView.af.setImage(withURL: url)
        if let iconUrl = viewModel.getGameIconImageUrl(){
            gameIconImageView.af.setImage(withURL: iconUrl)
        }
        gameGenresLabel.text = viewModel.getGameGenres()
        gameDescription.text = viewModel.getGameDescription()
        if viewModel.isGameFavorited() {
            favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        self.detailTagsCollectionView.reloadData()

        //self.moreGamesCollectionView.reloadData()
    }
    func similarGamesLoaded() {
        self.moreGamesCollectionView.reloadData()
        self.detailTagsCollectionView.reloadData()
    }
}

extension GameDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailTagsCollectionView {
            return 4
        }
        if collectionView == moreGamesCollectionView {
            return viewModel.getSimilarGamesCount()
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailTagsCollectionView {
            let cell = detailTagsCollectionView.dequeueReusableCell(withReuseIdentifier: "detailTagCollectionViewCell", for: indexPath) as! DetailTagCollectionViewCell
            cell.setup(rating: viewModel.getGameRating(), ratingCount: viewModel.getGameReviewCount(), year: viewModel.getGameReleaseYear(), developer: viewModel.getGameDeveloperName(), added: viewModel.getGameAddedCount(), index: indexPath.row)
            return cell
        }
        if collectionView == moreGamesCollectionView {
            guard let cell = moreGamesCollectionView.dequeueReusableCell(withReuseIdentifier: "moreGamesCell", for: indexPath) as? MoreGamesCollectionViewCell,
                  let game = viewModel.getSimilarGame(at: indexPath.row) else {return UICollectionViewCell()}
            cell.configureCell(game: game)
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else {return}
        detailVC.gameId = viewModel.getSimilarGame(at: indexPath.row)?.id
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    
}

