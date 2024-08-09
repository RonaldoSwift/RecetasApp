//
//  DetalleRepository.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 7/08/24.
//

import Foundation
import Combine

class DetalleRepository {
    
    private let recetasWebService: RecetasWebService
    
    var cancelLables = Set<AnyCancellable>()
    
    init(recetasWebService: RecetasWebService) {
        self.recetasWebService = recetasWebService
    }
    
    func getDetalleFromWebService(id: Int) -> AnyPublisher<Detalle ,Error> {
        return recetasWebService.getDetalleReceta(id: id).map { (detalleResponse:DetalleResponse) in
            Detalle(
                readyInMinutes: detalleResponse.readyInMinutes ?? 0,
                cookingMinutes: detalleResponse.cookingMinutes ?? 0,
                preparationMinutes:
                    detalleResponse.preparationMinutes ?? 0,
                summary: detalleResponse.summary
            )
        }
        .eraseToAnyPublisher()
    }
}
