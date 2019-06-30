//
//  ViewControllerExtensions.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/30/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import UIKit

extension UIViewController {
   
   func displayAlertWithTitle(_ title: String?, message: String){
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default) { (_) in }
      alertController.addAction(okAction)
      
      self.present(alertController, animated: true, completion: nil)
   }
   
}
