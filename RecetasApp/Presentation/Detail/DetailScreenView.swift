//
//  DetailScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import SwiftUI
import Kingfisher

struct DetailScreenView: View {
    
    @EnvironmentObject private var sharedRecetaViewModel : SharedRecetaViewModel
    @StateObject private var detailScreenViewModel = DetailScreenViewModel(
        recetaRepository: RecetaRepository(
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
    @State private var showModal: Bool = false
    
    var body: some View {
        
        VStack {
            if showLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                VStack {
                    ScrollView {
                        VStack(spacing: 0) { // Espaciado de 0 elimina el espacio entre los elementos
                            KFImage(URL(string: sharedRecetaViewModel.receta?.image ?? "Error"))
                                .resizable()
                                .scaledToFill()
                                .background(Color.red)
                                .frame(maxWidth: .infinity, maxHeight: 250)
                                .clipped()
                            
                            DetalleCard(
                                tituloDeReceta: sharedRecetaViewModel.receta?.title ?? "Error",
                                tiempo: cookingMinutes,
                                calorias: preparationMinutes,
                                personas: readyInMinutes
                            )
                            HStack {
                                Text("Instrucciones")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Spacer()
                            }
                            .padding(.leading, 20)
                            Text(resumen)
                                .padding()
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
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
                //Altura exacta del Stuts Bar
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.top)
            }
        }
        
        .toolbar(content: {
            TextUserToolbarContent(tituloDePantalla: "Detalle", onClick: {
                showModal = true
            })
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
        .onAppear(perform: {
            print("Hola")
            detailScreenViewModel.startDetalle(id: sharedRecetaViewModel.receta?.id ?? -1)
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
        .sheet(isPresented: $showModal, content: {
            UserScreenModalView(
                onClickBack: {
                    showModal = false
                }, onClickSave: {
                    showModal = false
                })
        })
    }
}

#Preview {
    DetailScreenView()
}
