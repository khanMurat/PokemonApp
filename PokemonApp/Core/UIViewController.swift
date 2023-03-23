//
//  ViewController.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(error : ApiError) {
        
        let alertController = UIAlertController(title : Constants.error,
                                                message : error.localizedDescription,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.ok, style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
