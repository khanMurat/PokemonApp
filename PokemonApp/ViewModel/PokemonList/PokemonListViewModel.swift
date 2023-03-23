//
//  PokemonListViewModel.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//


import Foundation

class PokemonListViewModel {
    
    private let apiService : ApiService
    
    var pokemonDetails : [PokemonDetail] = []
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchPokemons(completion:@escaping (Result<Void,ApiError>) -> Void) {
        
           apiService.fetchPokemonList {[weak self] (result) in
               switch result {
               case .success(let pokemons):
                   self?.apiService.fetchPokemonDetail(pokemon: pokemons, completion: { detailsResult in
                       switch detailsResult {
                       case .success(let details):
                           self?.pokemonDetails = details
                           completion(.success(()))
                       case .failure(let error):
                           print(error)
                           completion(.failure(error))
                       }
                   })
               case .failure(let error):
                   completion(.failure(error))
               }
           }
           
       }
    
    func numberOfRowsInSection()->Int{
        return pokemonDetails.count
    }
    
    func viewModelForCell(at index : Int ) -> PokemonDetail {
        return pokemonDetails[index]
    }
}





