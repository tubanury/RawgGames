//
//  GameTableViewCell.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 6.12.2022.
//

import UIKit
import AlamofireImage

final class GameTableViewCell: UITableViewCell {

    @IBOutlet  weak var gameImage: UIImageView!
    @IBOutlet  weak var gameName: UILabel!
    @IBOutlet weak var gameGenre: UILabel!
    @IBOutlet weak var gameRating: UIButton!
    @IBOutlet weak var gameAdded: UIButton!
    @IBOutlet weak var gameTag: UIButton!
    
    func configureCell(game: GameModel){
        gameName.text = game.name
        gameGenre.text = game.genres.first?.name
        gameRating.setTitle(String(game.rating), for: .normal)
        gameAdded.setTitle(String(game.added/1000)+"K", for: .normal)
        gameTag.setTitle(game.tags.first?.name, for: .normal)

        guard let url = URL(string: game.backgroundImage) else {return}
        gameImage.af.setImage(withURL: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImage.image = nil
        gameName.text = ""
        gameGenre.text = ""
        gameRating.setTitle("", for: .normal)
        gameAdded.setTitle("", for: .normal)
        gameTag.setTitle("", for: .normal)
    }
}
