//
//  DetailScreenUiState.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 7/08/24.
//

import Foundation

enum DetailScreenUiState {
    case inicial
    case cargando
    case error(String)
    case success(Detalle)
}
