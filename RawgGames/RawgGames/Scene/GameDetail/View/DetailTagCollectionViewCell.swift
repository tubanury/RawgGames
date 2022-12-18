//
//  detailTagCollectionViewCell.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 13.12.2022.
//

import UIKit

final class DetailTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var subTitle: UILabel!
    
    func setup(rating: Double, ratingCount: Int, year: String, developer: String, added: Int, index: Int){
        switch index{
            case 0:
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
                button.setTitle(String(rating), for: .normal)
                subTitle.text = String(ratingCount/1000)+"K " + "reviews"
                self.layer.addBorder(edge: .right, color: .systemGray4, thickness: 2)
            case 1:
                button.setImage(UIImage(systemName: "calendar"), for: .normal)
                button.setTitle(year, for: .normal)
                subTitle.text = "Released"
                self.layer.addBorder(edge: .right, color: .systemGray4, thickness: 2)
            case 2:
                button.setImage(UIImage(systemName: "arrow.down.to.line.compact"), for: .normal)
                button.setTitle(String(added/1000)+"K+", for: .normal)
                subTitle.text = "Downloads"
                self.layer.addBorder(edge: .right, color: .systemGray4, thickness: 2)

            case 3:
                button.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
                button.setTitle(developer, for: .normal)
                subTitle.text = "Developers"

            default:
                button.setImage(UIImage(systemName: ""), for: .normal)
        }
        
    }
}
