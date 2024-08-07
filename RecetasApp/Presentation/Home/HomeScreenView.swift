//
//  HomeScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    var onClickInDetail: () -> Void
    
    @StateObject private var homeScreenViewModel = HomeScreenViewModel(
        recetaRepository: RecetaRepository(
            recetasWebService: RecetasWebService()
        )
    )
    
    @State private var nombreDeReceta: String = ""
    @State private var arrayDeReceta: [Receta] = []

    @State private var titulo: String = ""
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)

                    TextField("Buscar...", text: $nombreDeReceta)
                        .padding(.leading, 5)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
            }
            .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(arrayDeReceta, id: \.id) { receta in
                        RecetaCard(
                            clickEnLaTarjeta: {
                                onClickInDetail()
                            },
                            urlImage: receta.image,
                            nombreDeComida: receta.title
                        )
                    }
                }
            }
        }
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
