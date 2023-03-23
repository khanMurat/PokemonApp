//
//  ApiError.swift
//  PokemonApp
//
//  Created by Murat on 22.03.2023.
//

import Foundation

enum ApiError : Error {
    
    case invalidURL
    case noData
    case emptyData
    case decodingError
    
}
