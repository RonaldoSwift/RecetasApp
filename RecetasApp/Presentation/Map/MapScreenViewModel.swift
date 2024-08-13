//
//  MapScreenViewModel.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation
import Combine

@MainActor
final class MapScreenViewModel: ObservableObject {
    
    let restauranteRepository: RestauranteRepository
    
    var cancelLables = Set<AnyCancellable>()
    
    @Published private(set) var mapScreenUiState = MapScreenUiState.inicial
    
    init(detalleRestauranteRepository: RestauranteRepository) {
        self.restauranteRepository = detalleRestauranteRepository
        startRestaurant()
    }
    
    func startRestaurant() {
        mapScreenUiState = MapScreenUiState.cargando
        
        restauranteRepository.getRestaurantesFromWebService()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .finished:
                    break
                case .failure(let error):
                    self.mapScreenUiState = MapScreenUiState.error("Error: \(error)")
                }
            }, receiveValue: { ( restaurantes: [Restaurante]) in
                self.mapScreenUiState = MapScreenUiState.success(restaurantes)
            })
            .store(in: &cancelLables)
    }
}
