//
//  HomeScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    @StateObject private var homeScreenViewModel = HomeScreenViewModel(
        recetaRepository: RecetaRepository(
            recetasWebService: RecetasWebService()
        )
    )
    @State private var titulo: String = ""
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    
    var body: some View {
        VStack {
            Text("Lista")
            
            List {
                Text(titulo)
            }
            
            Button(action: {
                homeScreenViewModel.startReceta(nombreDeReceta: "")
            }, label: {
                Text("Button")
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(mensajeDeAlerta),
                dismissButton: .default(
                    Text("Error"),
                    action: {
                    }
                )
            )
        }
        .onReceive(homeScreenViewModel.$homeScreenUiState, perform: { homeState in
            switch(homeState) {
            case .inicial:
                break
            case .cargando:
                showLoading = true
            case .error(let error):
                showAlert = true
                showLoading = false
                mensajeDeAlerta = error
            case .success(let primeraComida):
                titulo = primeraComida
                showLoading = false
            }
        })
    }
}

#Preview {
    HomeScreenView()
}
