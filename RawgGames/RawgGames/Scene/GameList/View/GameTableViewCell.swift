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
        gameAdded.setTitle(String(game.added/1000) + Localizables.thousandShortening.value, for: .normal)
        gameTag.setTitle(game.tags.first?.name, for: .normal)

        guard let backgroundImage = game.backgroundImage else {return}
        CacheManager.shared.getImage(id: game.id, imageString: backgroundImage) { image in
            self.gameImage.image = image
        }
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImage.image = nil
    }
}
