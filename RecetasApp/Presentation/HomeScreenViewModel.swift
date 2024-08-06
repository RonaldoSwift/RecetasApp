//
//  HomeScreenViewModel.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation
import Combine

@MainActor
final class HomeScreenViewModel: ObservableObject {
    
    let recetaRepository: RecetaRepository
    
    var cancelLables = Set<AnyCancellable>()
    
    @Published private(set) var homeScreenUiState = HomeScreenUiState.inicial

    init(recetaRepository: RecetaRepository) {
        self.recetaRepository = recetaRepository
    }
    
    func startReceta(nombreDeReceta: String) {
        
        homeScreenUiState = HomeScreenUiState.cargando
        
        recetaRepository.getRecetaFromWebService(
            nombreDeReceta: nombreDeReceta
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch(completion) {
            case .finished:
                break
            case .failure(let error):
                self.homeScreenUiState = HomeScreenUiState.error("Ocurrio un Error \(error)")
            }
        }, receiveValue: { (recetas: [Receta]) in
            let primeraComida = recetas[0]
            self.homeScreenUiState = HomeScreenUiState.success("\(primeraComida)")
        })
        .store(in: &cancelLables)
        
    }
}
