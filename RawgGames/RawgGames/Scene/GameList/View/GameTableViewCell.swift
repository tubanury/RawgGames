//
//  GameTableViewCell.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit
import AlamofireImage

final class GameTableViewCell: UITableViewCell {

    @IBOutlet private weak var gameImage: UIImageView!
    @IBOutlet private weak var gameName: UILabel!

    func configureCell(game: GameModel){
        gameName.text = game.name
        guard let url = URL(string: game.backgroundImage) else {return}
        gameImage.af.setImage(withURL: url)
    }
}
