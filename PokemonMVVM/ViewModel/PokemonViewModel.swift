//
//  PokemonViewModel.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/28/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import Foundation

enum PokemonVerificationState {
   case success(String)
   case failure(String)
}

enum PokemonAlertMessages : String {
   case rightAnswer = "Correct."
   
   case wrongAnswer = "Wrong answer."
   case genericError = "Internal error has occurred."
}

class PokemonViewModel {
   
   private let pokemonDataModel : PokemonDataModel
   var selectedPokemon : DynamicType<Pokemon> = DynamicType()
   
   init(pokemonDataModel : PokemonDataModel) {
      self.pokemonDataModel = pokemonDataModel
      selectNewPokemon()
   }
   
   private var randomPokemon : Pokemon?{
      return pokemonDataModel.pokemons.randomElement()
   }
}

extension PokemonViewModel {
   func selectNewPokemon(){
      guard let pokemon = randomPokemon else { return }
      selectedPokemon.value = pokemon
   }
   
   func verify(guess: String?) -> PokemonVerificationState {
      guard let pokemon = selectedPokemon.value else {
         return PokemonVerificationState.failure(PokemonAlertMessages.genericError.rawValue)
      }
      
      let correctPokemonNameMessage = " The answer was \(pokemon.name)"
      guard let userGuess = guess, userGuess.isEmpty != true else {
         return PokemonVerificationState.failure(PokemonAlertMessages.wrongAnswer.rawValue + correctPokemonNameMessage)
      }
      
      if userGuess.lowercased() == pokemon.name.lowercased() {
         return PokemonVerificationState.success(PokemonAlertMessages.rightAnswer.rawValue)
      }else {
         return PokemonVerificationState.failure(PokemonAlertMessages.wrongAnswer.rawValue + correctPokemonNameMessage)
      }
   }
}
