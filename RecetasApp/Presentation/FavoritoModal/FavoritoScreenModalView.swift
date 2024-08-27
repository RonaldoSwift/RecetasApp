//
//  FavoritoScreenModalView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 21/08/24.
//

import Foundation
import SwiftUI

struct FavoritoScreenModalView: View {
    
    //Sirve para compartir estados entre pantallas con pantallas con comopnentes
    //@Binding var recetas: [Receta]
    
    @StateObject private var favoritoScreenModalViewModel = FavoritoScreenModalViewModel(
        recetaRepository: RecetaRepository(
            recetasWebService: RecetasWebService(),
            dataBaseGRDB: RecetaGRDB()
        )
    )
    
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var tituloDeAlerta: String = ""
    @State private var arrayDeRecetaEnBaseDeDatos: [Receta] = []

    var body: some View {
        NavigationView {
            VStack {
                if showLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(arrayDeRecetaEnBaseDeDatos, id: \.id) { receta in
                                RecetaCard(
                                    clickEnLaTarjeta: {},
                                    clickEnButtonCorazon: {},
                                    urlImage: receta.image,
                                    nombreDeComida: receta.title
                                )
                            }
                            .padding()
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("Favorito")
                                }
                            }
                        }
                    }
                }
            }
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
            .onReceive(favoritoScreenModalViewModel.$favoritoScreenModalViewUiState, perform: { favoriteState in
                switch(favoriteState) {
                case .incial:
                    break
                case .cargando:
                    showLoading = true
                case .error(let error):
                    tituloDeAlerta = "Error en Base de Datos"
                    mensajeDeAlerta = error
                    showAlert = true
                    showLoading = false
                case .success(let recetas):
                    arrayDeRecetaEnBaseDeDatos = recetas
                    showLoading = false
                }
            })
        }
    }
}
