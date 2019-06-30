//
//  PokemonAPIClient.swift
//  PokemonMVVM
//
//  Created by Junior Etrata on 6/28/19.
//  Copyright © 2019 Junior Etrata. All rights reserved.
//

import Foundation

enum Request<T> {
   case success(T)
   case failure(Error?)
}

struct PokemonNetworking {
   typealias ResponseHandler = (Data)->()
   typealias RequestHandler  = (Request<Data>)->()
   
   private let endpoint: URL!
   
   init(withURL url: URL) {
      self.endpoint = url
   }
   
   fileprivate func downloadTask(url: URL, completion: @escaping RequestHandler){
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if error == nil{
            guard let res = response as? HTTPURLResponse else { fatalError()}
            if res.statusCode == 200{
               guard let pokemonData = data else { fatalError()}
               completion(.success(pokemonData))
            }
         }else{
            completion(.failure(error))
         }
      }.resume()
   }
   
   func downloadPokemonData(completion: @escaping((PokemonDataModel) -> Void)){
      downloadTask(url: self.endpoint) { (request) in
         switch request{
            
         case .success(let pokemonData):
            do {
               let pokemons = try PokemonDataModel(data: pokemonData)
               completion(pokemons)
            }catch let parsingError {
               print("Error: \(parsingError)")
            }
         case .failure(_):
            break
         }
      }
   }
   
   func downloadPokemonImage(withURL url: URL, completion: @escaping ResponseHandler){
      downloadTask(url: url) { (request) in
         switch request{
            
         case .success(let imageData):
            completion(imageData)
         case .failure(_):
            break
         }
      }
   }
}
