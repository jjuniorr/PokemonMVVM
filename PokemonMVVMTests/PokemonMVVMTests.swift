//
//  PokemonMVVMTests.swift
//  PokemonMVVMTests
//
//  Created by Junior Etrata on 6/27/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import XCTest
@testable import PokemonMVVM

class PokemonMVVMTests: XCTestCase {

   var playerViewModel : PlayerViewModel!
   var networking : PokemonNetworking!
   
    override func setUp() {
      playerViewModel = PlayerViewModel()
      networking = PokemonNetworking(withURL: URL(string: Constants.pokemonAPI)!)
    }

    override func tearDown() {
      super.tearDown()
      playerViewModel = nil
      networking = nil
    }

    func testPlayerViewModel() {
      playerViewModel.incrementScore()
      XCTAssert(playerViewModel.playerScore.value != nil)
      XCTAssert(playerViewModel.playerScore.value! == "Correct: 1")
      playerViewModel.decrementScore()
      XCTAssert(playerViewModel.playerScore.value! == "Correct: 0")
    }
   
   func testNetworking(){
      networking.downloadPokemonData { (pokemonDataModel) in
         XCTAssert(pokemonDataModel.pokemons.count == 151)
         XCTAssert(pokemonDataModel.pokemons[0].name == "Bulbasaur")
         XCTAssert(pokemonDataModel.pokemons[150].name == "Mew")
      }
   }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
         networking.downloadPokemonData { [unowned self] (pokemonDataModel) in
            self.networking.downloadPokemonImage(withURL: pokemonDataModel.pokemons[0].imgURLString, completion: { (_) in
            })
         }
            // Put the code you want to measure the time of here.
        }
    }

}
