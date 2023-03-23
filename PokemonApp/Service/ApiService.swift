//
//  ApiService.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import Foundation
import Alamofire

class ApiService {
    
    
    func fetchPokemonList(completion : @escaping (Result<[Pokemon],ApiError>) -> Void) {
        
        let urlString = "\(Constants.baseURL)pokemon?limit=40"
        
        
        AF.request(urlString).responseDecodable(of: PokemonList.self) { (response) in
            
            switch response.result {
            case .success(let pokemonList):
                if pokemonList.results.isEmpty {
                    completion(.failure(.emptyData))
                }else{
                    completion(.success(pokemonList.results))
                }
            case .failure:
                completion(.failure(.noData))
            }
            
        }
    }
    
    func fetchPokemonDetail(pokemon:[Pokemon],completion : @escaping (Result<[PokemonDetail],ApiError>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var pokemonDetails : [PokemonDetail] = []
        
        
        for poke in pokemon {
            dispatchGroup.enter()
            
            AF.request(poke.url).responseDecodable(of: PokemonDetail.self) { (response) in
                
                if let detail = response.value {
                    pokemonDetails.append(detail)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
            completion(.success(pokemonDetails))
        }
    }
    
}
