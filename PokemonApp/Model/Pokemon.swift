//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import Foundation

struct PokemonList : Codable {
    
    let results : [Pokemon]
}

struct Pokemon : Codable {
    
    let name : String
    let url : String
}

struct PokemonDetail : Codable {
    let name : String
    let sprites : PokemonSprites
    let abilities : [AbilityWrapper]
   
}

struct PokemonSprites : Codable {
    let front_default : String
}

struct AbilityWrapper : Codable {
    
    let ability : Ability
}

struct Ability : Codable {
    
    let name : String
    let url : String
}
