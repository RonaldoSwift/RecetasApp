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
            recetasWebService: RecetasWebService(),
            dataBaseGRDB: RecetaGRDB()
        )
    )
    
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var tituloDeAlerta = ""
    @State private var mensajeDeAlerta: String = ""
    @State private var showModal = false
    @State private var clickEnCorazon = false
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
                                }, clickEnButtonCorazon: {
                                    homeScreenViewModel.insertarEnBaseDeDatos(
                                        id: receta.id,
                                        title: receta.title,
                                        image: receta.image
                                    )
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
                title: Text(tituloDeAlerta),
                message: Text(mensajeDeAlerta),
                dismissButton: .default(
                    Text("Aceptar"),
                    action: {
                    }
                )
            )
        }
        .toolbar {
            TextHomeToolbarContent(
                tituloDePantalla: "Favorito") {
                    showModal = true
                }
        }
        .sheet(isPresented: $showModal) {
            FavoritoScreenModalView()
        }
        .onReceive(homeScreenViewModel.$homeScreenUiState, perform: { homeState in
            switch(homeState) {
            case .inicial:
                break
            case .cargando:
                showLoading = true
            case .errorDeWebService(let error):
                tituloDeAlerta = "Error de Web Service"
                mensajeDeAlerta = error
                showAlert = true
                showLoading = false
            case .successDeWebService(let recetas):
                arrayDeReceta = recetas
                showLoading = false
            case .guardadoEnFavoritoDB(let mensajeEnBD):
                tituloDeAlerta = "Genial!!"
                mensajeDeAlerta = mensajeEnBD
                showAlert = true
            case .errorGuardadoFavoritoDB(let errorEnBD):
                tituloDeAlerta = "Error"
                mensajeDeAlerta = errorEnBD
                showAlert = true
            }
        })
    }
}

#Preview {
    HomeScreenView(onClickInDetail: {})
}
