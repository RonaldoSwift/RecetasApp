//
//  MapScreenUiState.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation

enum MapScreenUiState {
    case inicial
    case cargando
    case error(String)
    case success([Restaurante])
}
