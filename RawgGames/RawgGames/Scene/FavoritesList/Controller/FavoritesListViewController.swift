//
//  FavoritesListViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 11.12.2022.
//

import UIKit

class FavoritesListViewController: UIViewController {

    @IBOutlet weak var favoritesListTableView: UITableView!{
        didSet {
           // favoritesListTableView.delegate = self
           // favoritesListTableView.dataSource = self
        }
    }

}
