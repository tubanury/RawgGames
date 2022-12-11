//
//  FavoritesListTableViewCell.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 11.12.2022.
//

import UIKit

class FavoritesListTableViewCell: UITableViewCell {

    @IBOutlet private weak var gameImage: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteBtn: (() -> ())?
    
    func configureCell(game: Game){
        gameImage.image = UIImage(data: game.image!)
       
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteBtn?()
    }
}
