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
}
