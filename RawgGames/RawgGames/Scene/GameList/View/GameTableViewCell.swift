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
        gameAdded.setTitle(String(game.added/1000)+"K", for: .normal)
        gameTag.setTitle(game.tags.first?.name, for: .normal)

        //guard let url = URL(string: game.backgroundImage) else {return}
        //gameImage.af.setImage(withURL: url)
        
        if let cachedImage = self.cache.object(forKey: game.id as NSNumber) {
                   print("Using a cached image for item: \(game.id)")
                self.gameImage.image = cachedImage
        } else {
           // 4
            self.loadImage(game: game) { [weak self] (image) in
               guard let self = self, let image = image else { return }
               
               self.gameImage.image = image
               // 5
               self.cache.setObject(image, forKey: game.id as NSNumber)
           }
        }
        
        
        /*GameClient.fetchImage(withUrlString: game.backgroundImage) { image in
            DispatchQueue.main.async {
                self.gameImage.image = image
            }
        }*/
    }
    
    
    private func loadImage(game: GameModel, completion: @escaping (UIImage?) -> ()) {
          utilityQueue.async {
              let url = URL(string: game.backgroundImage)!
              
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
        gameName.text = ""
        gameGenre.text = ""
        gameRating.setTitle("", for: .normal)
        gameAdded.setTitle("", for: .normal)
        gameTag.setTitle("", for: .normal)
    }
}
