//
//  DetailScreenViewModel.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 7/08/24.
//

import Foundation
import Combine

@MainActor
final class DetailScreenViewModel: ObservableObject {
    let recetaRepository: RecetaRepository
    
    var cancelLables = Set<AnyCancellable>()
    
    @Published private(set) var detailScreenUiState = DetailScreenUiState.inicial
    
    init(recetaRepository: RecetaRepository) {
        self.recetaRepository = recetaRepository
    }
    
    func startDetalle(id: Int) {
        detailScreenUiState = DetailScreenUiState.cargando
        
        recetaRepository.getDetalleFromWebService(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .finished:
                    break
                case .failure(let error):
                    self.detailScreenUiState = DetailScreenUiState.error("Ocurrio un error \(error)")
                }
            }, receiveValue: { (detalle: Detalle) in
                self.detailScreenUiState = DetailScreenUiState.success(detalle)
            })
            .store(in: &cancelLables)
    }
}
