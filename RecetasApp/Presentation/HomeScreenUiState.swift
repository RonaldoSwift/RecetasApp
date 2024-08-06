//
//  HomeScreenUiState.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation

enum HomeScreenUiState {
    case inicial
    case cargando
    case error(String)
    case success([Receta])
}
