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
    case errorDeWebService(String)
    case successDeWebService([Receta])
    case guardadoEnFavoritoDB(String)
    case errorGuardadoFavoritoDB(String)
}
