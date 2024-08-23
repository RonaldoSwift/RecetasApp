//
//  FavoritoScreenModalViewUiState.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 21/08/24.
//

import Foundation

enum FavoritoScreenModalViewUiState {
    case incial
    case cargando
    case error(String)
    case success([Receta])
}
