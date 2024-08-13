//
//  RecetaRepository.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation
import Combine

class RecetaRepository {
    
    private let recetasWebService: RecetasWebService
    
    var cancelLables = Set<AnyCancellable>()
    
    init(recetasWebService: RecetasWebService) {
        self.recetasWebService = recetasWebService
    }
    
    func getRecetaFromWebService(nombreDeReceta:String) -> AnyPublisher<[Receta] ,Error> {
        return recetasWebService.getReceta(nombreDeReceta: nombreDeReceta)
            .map { (recetaResponse:RecetaResponse) in
                recetaResponse.results.map { recetaResponse in
                    Receta(
                        id: recetaResponse.id,
                        title: recetaResponse.title,
                        image: recetaResponse.image
                    )
                }
            }
            .eraseToAnyPublisher()
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
