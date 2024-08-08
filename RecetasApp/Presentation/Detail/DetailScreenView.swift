//
//  DetailScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import SwiftUI

struct DetailScreenView: View {
    
    @StateObject private var detailScreenViewModel = DetailScreenViewModel(
        detalleRepository: DetalleRepository(
            recetasWebService:
                RecetasWebService()
        )
    )
    @State private var titulo: String = ""
    @State private var irAMap: Bool = false
    @State private var showLoading: Bool = false
    @State private var showAlert:Bool = false
    @State private var mensajeDeAlerta: String = ""
    
    var body: some View {
        VStack {
            if showLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                Text("Hello, World!")
                Button {
                    irAMap = true
                } label: {
                    Text("Map")
                }
                
                Text(titulo)
                
                Button {
                    detailScreenViewModel.startDetalle()
                } label: {
                    Text("Push")
                }
            }
        }
        .toolbar(content: {
            TextToolbarContent(tituloDePantalla: "Detalle")
        })
        .navigation(MapScreenView(), $irAMap)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Error"),
                message: Text(mensajeDeAlerta),
                dismissButton: .default(
                    Text("Aceptar"),
                    action: {
                    }
                )
            )
        })
        .onReceive(detailScreenViewModel.$detailScreenUiState) { detailState in
            switch(detailState) {
            case .inicial:
                break
            case .cargando:
                showLoading = true
            case .error(let error):
                showAlert = true
                showLoading = false
                mensajeDeAlerta = error
            case .success(let detalle):
                titulo = "\(detalle)"
                showLoading = false
            }
        }
    }
}

#Preview {
    DetailScreenView()
}
