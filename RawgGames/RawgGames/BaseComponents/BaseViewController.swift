//
//  BaseViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 15.12.2022.
//

import UIKit
import MaterialActivityIndicator

class BaseViewController: UIViewController {

    let indicator = MaterialActivityIndicatorView()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
   
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func presentAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Localizables.tryAgain.value, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
