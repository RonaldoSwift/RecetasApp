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
        startReceta(nombreDeReceta: "")
        observarPublicadorDeInsertarReceta()
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
                self.homeScreenUiState = HomeScreenUiState.errorDeWebService("Ocurrio un Error \(error)")
            }
        }, receiveValue: { (recetas: [Receta]) in
            self.homeScreenUiState = HomeScreenUiState.successDeWebService(recetas)
        })
        .store(in: &cancelLables)
    }
    
    func insertarEnBaseDeDatos(id: Int, title: String, image: String) {
        recetaRepository.insertarRecetaEnBaseDeDatos(
            id: id,
            title: title,
            image: image
        )
    }
    
    func llamarRecetaDeBaseDeDatos() {
        recetaRepository.llamarRecetaDeBaseDeDatos()
    }
    
    func observarPublicadorDeInsertarReceta() {
        recetaRepository.publicadorDeInsertarReceta()
        //Hilo secundario se hace el proceso pesado
            .subscribe(on: DispatchQueue.global(qos: .background))
        //Volvemso al Hilo principal
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .finished:
                    break
                case .failure(let error):
                    self.homeScreenUiState = HomeScreenUiState.errorGuardadoFavoritoDB("Ocurrio un Error \(error)")
                }
            }, receiveValue: { (mensaje:String) in
                self.homeScreenUiState = HomeScreenUiState.guardadoEnFavoritoDB(mensaje)
            })
            .store(in: &cancelLables)
    }
}
