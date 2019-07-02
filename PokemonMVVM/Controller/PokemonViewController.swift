//
//  PokemonViewController.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/27/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
   
   @IBOutlet weak var correctAnswersLabel: UILabel!
   @IBOutlet weak var pokemonImgView: UIImageView!
   @IBOutlet weak var pokemonTextField: UITextField!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   private var pokemonAPIClient = PokemonNetworking(withURL: URL(string: Constants.pokemonAPI)!)
   private var pokemonViewModel : PokemonViewModel?
   private var playerViewModel = PlayerViewModel()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      activityIndicator.startAnimating()
      pokemonAPIClient.downloadPokemonData { [weak self] (pokemonDataModel) in
         self?.pokemonViewModel = PokemonViewModel(pokemonDataModel: pokemonDataModel)
         self?.setupBinding()
      }
   }
   
   private func setupBinding(){
      pokemonViewModel?.selectedPokemon.bind({ [unowned self] (pokemon) in
         self.pokemonAPIClient.downloadPokemonImage(withURL: pokemon.imgURLString, completion: { (imageData) in
            DispatchQueue.main.async {
               self.pokemonImgView.image = UIImage(data: imageData)
               self.activityIndicator.stopAnimating()
            }
         })
      })
      playerViewModel.playerScore.bind { [unowned self] (score) in
         DispatchQueue.main.async {
            self.correctAnswersLabel.text = score
         }
      }
   }
   
   @IBAction func guessThePokemon(_ sender: UIButton) {
      guard let viewModel = pokemonViewModel else { return }
      switch viewModel.verify(guess: pokemonTextField.text){
      case .success(let message):
         displayAlertWithTitle("Pokemon Message", message: message)
         playerViewModel.incrementScore()
      case .failure(let message):
         displayAlertWithTitle("Pokemon Message", message: message)
         playerViewModel.decrementScore()
      }
      pokemonTextField.text?.removeAll()
      viewModel.selectNewPokemon()
      activityIndicator.startAnimating()
   }
}

extension PokemonViewController : UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
}
