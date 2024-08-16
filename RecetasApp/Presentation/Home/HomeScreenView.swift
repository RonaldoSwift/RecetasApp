//
//  HomeScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    var onClickInDetail: () -> Void
    
    @EnvironmentObject private var sharedRecetaViewModel : SharedRecetaViewModel
    @StateObject private var homeScreenViewModel = HomeScreenViewModel(
        recetaRepository: RecetaRepository(
            recetasWebService: RecetasWebService()
        )
    )
    
    @State private var nombreDeReceta: String = ""
    @State private var arrayDeReceta: [Receta] = []
    @State private var searchText = ""
    
    var resultadosBusquedaDeReceta: [Receta] {
        if searchText.isEmpty {
            return arrayDeReceta
        } else {
            return arrayDeReceta.filter { (receta: Receta) in
                receta.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    
    var body: some View {
        VStack {
            if showLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(resultadosBusquedaDeReceta, id: \.id) { receta in
                            RecetaCard(
                                clickEnLaTarjeta: {
                                    sharedRecetaViewModel.receta = receta
                                    onClickInDetail()
                                },
                                urlImage: receta.image,
                                nombreDeComida: receta.title
                            )
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText) // aumenta la barra de buscar
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Home"))
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(mensajeDeAlerta),
                dismissButton: .default(
                    Text("Aceptar"),
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
            case .success(let recetas):
                arrayDeReceta = recetas
                showLoading = false
            }
        })
    }
}

#Preview {
    HomeScreenView(onClickInDetail: {})
}
