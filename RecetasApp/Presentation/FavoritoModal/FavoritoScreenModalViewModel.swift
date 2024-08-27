//
//  FavoritoScreenModalViewModel.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 21/08/24.
//

import Foundation
import Combine

@MainActor
final class FavoritoScreenModalViewModel: ObservableObject {
    
    let recetaRepository: RecetaRepository
    var cancelLables = Set<AnyCancellable>()
    
    var aniCancelable : AnyCancellable? = nil
    
    @Published private(set) var favoritoScreenModalViewUiState = FavoritoScreenModalViewUiState.incial

        
    init(recetaRepository: RecetaRepository) {
        self.recetaRepository = recetaRepository
        observarPublicadorDeListaDeRecetas() //Primero observamos
        recetaRepository.llamarListaDeRecetas() // Luego enviamos un valor
    }
    
    func observarPublicadorDeListaDeRecetas() {
        recetaRepository.publicadorDeListaDeRecetas()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .finished:
                    print("Finnish")
                        break
                case .failure(let error):
                    self.favoritoScreenModalViewUiState = FavoritoScreenModalViewUiState.error("Ocurrio un error \(error)")
                }
            }, receiveValue: { (recetas: [Receta]) in
                self.favoritoScreenModalViewUiState = FavoritoScreenModalViewUiState.success(recetas)
            })
            .store(in: &cancelLables)
    }
}
