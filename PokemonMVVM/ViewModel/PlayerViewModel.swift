//
//  PlayerViewModel.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/28/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import Foundation

class PlayerViewModel {
   
   var playerScore : DynamicType<String> = DynamicType<String>()
   
   private var playerDataModel : PlayerDataModel {
      didSet{
         playerScore.value = "Correct: \(playerDataModel.score)"
      }
   }

   init(){
      playerDataModel = PlayerDataModel()
      playerScore.value = "Correct: 0"
   }
   
}

extension PlayerViewModel {
   func incrementScore() {
      playerDataModel.score += 1
   }
   
   func decrementScore(){
      playerDataModel.score -= 1
   }
}
