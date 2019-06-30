//
//  Pokemon.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/27/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import Foundation

struct PokemonDataModel: Codable {
   let pokemons : [Pokemon]
   
   enum CodingKeys : String, CodingKey {
      case pokemons = "pokemon"
   }
}

extension PokemonDataModel {
   init(data: Data) throws {
      self = try JSONDecoder().decode(PokemonDataModel.self, from: data)
   }
}

struct Pokemon : Codable{
   let name : String
   let imgURLString : URL
   
   enum CodingKeys : String, CodingKey {
      case name
      case imgURLString = "img"
   }
}
