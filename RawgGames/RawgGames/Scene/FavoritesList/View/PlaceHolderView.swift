//
//  PlaceHolderView.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 17.12.2022.
//

import UIKit

class PlaceHolderView: UIView {

    private lazy var containerView: UIView = {
       let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
    
        let temp = UIStackView(arrangedSubviews: [image, label])
        
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .center
        temp.distribution = .fillEqually
        temp.axis = .vertical
        temp.spacing = 0
        return temp
    }()
    
    private lazy var image: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints =  false
        temp.contentMode = .scaleAspectFit
        temp.image = UIImage(named: "noFavorite")
        return temp
        
    }()
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints =  false
        temp.font = UIFont(name: "Futura", size: 15)
        temp.text = "Burada hiç favori oyun yok."
        return temp
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        addSubview(containerView)
        containerView.addSubview(mainStackView)
       

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 250),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -250),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         
        ])
 
    }

}
