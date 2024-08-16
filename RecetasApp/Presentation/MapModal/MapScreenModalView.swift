//
//  MapScreenModalView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation
import SwiftUI

struct MapScreenModalView: View {
    
    @EnvironmentObject private var sharedMapaViewModel : SharedMapaViewModel
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var isOpen: Bool = false
    var onClickBackMap: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Spacer()
                Button {
                    onClickBackMap()
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .padding()
                }
            }
            
            Image(ImageResource.restaurante)
                .resizable()
                .scaledToFit()
                .multilineTextAlignment(.center)

            Text(sharedMapaViewModel.restaurante?.name ?? "")
                .font(.system(size: 20, weight: .bold))
                .lineLimit(nil)
                .allowsTightening(false)
                .multilineTextAlignment(.center)
            
            Text(sharedMapaViewModel.restaurante?.description ?? "")
                .padding()
                .foregroundColor(Color.black)
                .font(.system(size: 15, weight: .bold))
                .lineLimit(nil)
                .allowsTightening(false)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Telefono: ")
                        Text("\(sharedMapaViewModel.restaurante?.phoneNumber ?? 0)")
                    }
                    
                    HStack {
                        Text("Tipo de restaurante: ")
                        Text(sharedMapaViewModel.restaurante?.type ?? "No")
                    }
                    
                    HStack {
                        Text("Deleyveri:")
                        if(sharedMapaViewModel.restaurante?.deliveryEnabled == true) {
                            Text("Si")
                        } else {
                            Text("No")
                        }
                    }
                    
                    HStack {
                        Text("Abierto: ")
                        if (sharedMapaViewModel.restaurante?.isOpen == true) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.red)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding()
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
    }
}
