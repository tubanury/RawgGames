//
//  CacheManager.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 18.12.2022.
//

import Foundation
import UIKit

class CacheManager{
    static let shared = CacheManager()

    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    func getImage(id: Int, imageString: String,  completion: @escaping (UIImage?) -> ()) {
        if let cachedImage = self.cache.object(forKey: id as NSNumber) {
           completion(cachedImage)
        } else {
            self.loadImage(imageString: imageString) { [weak self] (image) in
               guard let self = self, let image = image else { return }
               self.cache.setObject(image, forKey: id as NSNumber)
               completion(image)
           }
        }
    }
    
    private func loadImage(imageString: String, completion: @escaping (UIImage?) -> ()) {
          utilityQueue.async {
              guard let url = URL(string: imageString) else {return}
              
              guard let data = try? Data(contentsOf: url) else { return }
              let image = UIImage(data: data)
              
              DispatchQueue.main.async {
                  completion(image)
              }
          }
      }
}
