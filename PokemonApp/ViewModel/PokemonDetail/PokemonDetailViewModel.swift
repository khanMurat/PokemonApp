//
//  PokemonDetailViewModel.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import Foundation

struct PokemonDetailViewModel {
    
    private let pokemonDetail : PokemonDetail
    
    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }
    
    var name : String {
        return pokemonDetail.name
    }
    
    var imageUlr: URL? {
        return URL(string: pokemonDetail.sprites.front_default)
    }
    
    var abilities : [String]{
        return pokemonDetail.abilities.map { $0.ability.name }
    }
    
}
