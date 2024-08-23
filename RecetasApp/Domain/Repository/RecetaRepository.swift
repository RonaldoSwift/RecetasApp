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
    private let dataBaseGRDB: RecetaGRDB
    
    var cancelLables = Set<AnyCancellable>()
    
    init(recetasWebService: RecetasWebService, dataBaseGRDB: RecetaGRDB) {
        self.recetasWebService = recetasWebService
        self.dataBaseGRDB = dataBaseGRDB
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
    
    func getPublicadorDeRecetaDeBaseDeDatos() ->AnyPublisher<[Receta],Error> {
        dataBaseGRDB.publicadorGetReceta.map { (recetaEntity: [RecetaEntity]) in
            recetaEntity.map { (recetaEntity: RecetaEntity) in
                Receta(
                    id: recetaEntity.id,
                    title: recetaEntity.title,
                    image: recetaEntity.image
                )
            }
        }
        .eraseToAnyPublisher()
    }
    
    func insertarRecetaEnBaseDeDatos(id:Int, title:String, image:String) {
        dataBaseGRDB.insertarRecetaALaTabla2(
            id: id,
            title: title,
            image: image
        )
    }
    
    func publicadorDeInsertarReceta() ->AnyPublisher<String,Error> {
        return dataBaseGRDB.publicadorInsertarReceta
            .eraseToAnyPublisher()
    }
    
    func llamarRecetaDeBaseDeDatos(onGetReceta: ([Receta]) -> Void) {
        dataBaseGRDB.getRecetaFromTable2(onGetRecetas: { recetaEntitys in
           let recetas = recetaEntitys.map { (recetaEntity:RecetaEntity) in
                Receta(
                    id: recetaEntity.id,
                    title: recetaEntity.title,
                    image: recetaEntity.image
                )
            }
            onGetReceta(recetas)
        })
    }
    
    func publicadorDeListaDeRecetas() ->AnyPublisher<[Receta],Error> {
        return dataBaseGRDB.publicadorGetReceta.map { (recetaEntitys:[RecetaEntity]) in
            recetaEntitys.map { (recetaEntity:RecetaEntity) in
                Receta(
                    id: recetaEntity.id,
                    title: recetaEntity.title,
                    image: recetaEntity.image
                )
            }
        }
        .eraseToAnyPublisher()
    }
}
