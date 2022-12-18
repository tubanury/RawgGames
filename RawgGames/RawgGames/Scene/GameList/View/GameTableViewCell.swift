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
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    
    func configureCell(game: GameModel){
        gameName.text = game.name
        gameGenre.text = game.genres.first?.name
        gameRating.setTitle(String(game.rating), for: .normal)
        gameAdded.setTitle(String(game.added/1000) + Localizables.thousandShortening.value, for: .normal)
        gameTag.setTitle(game.tags.first?.name, for: .normal)

        if let cachedImage = self.cache.object(forKey: game.id as NSNumber) {
            self.gameImage.image = cachedImage
        } else {
            self.loadImage(game: game) { [weak self] (image) in
               guard let self = self, let image = image else { return }
               self.gameImage.image = image
               self.cache.setObject(image, forKey: game.id as NSNumber)
           }
        }
        
    }
    
    private func loadImage(game: GameModel, completion: @escaping (UIImage?) -> ()) {
          utilityQueue.async {
              guard let url = URL(string: game.backgroundImage ?? "") else {return}
              
              guard let data = try? Data(contentsOf: url) else { return }
              let image = UIImage(data: data)
              
              DispatchQueue.main.async {
                  completion(image)
              }
          }
      }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImage.image = nil
    }
}
