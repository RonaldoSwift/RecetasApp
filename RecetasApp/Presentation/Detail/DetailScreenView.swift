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
    @State private var cookingMinutes: Int = 0
    @State private var preparationMinutes: Int = 0
    @State private var readyInMinutes: Int = 0
    @State private var resumen: String = ""
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
                VStack {
                    DetalleCard(
                        tituloDeReceta: "Holaaaa",
                        tiempo: cookingMinutes,
                        calorias: preparationMinutes,
                        personas: readyInMinutes
                    )
                    
                    HStack {
                        Text("Instrucciones")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(nil)
                            .allowsTightening(false)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(.leading,20)
                    
                    ScrollView {
                        Text(resumen)
                    }
                    .padding()
                    
                    Button {
                        irAMap = true
                    } label: {
                        Text("Ubicación")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.colorMorado)
                            .cornerRadius(30)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
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
                cookingMinutes = detalle.cookingMinutes
                preparationMinutes = detalle.preparationMinutes
                readyInMinutes = detalle.readyInMinutes
                resumen = detalle.summary
                showLoading = false
            }
        }
    }
}

#Preview {
    DetailScreenView()
}
