//
//  MapScreenModalView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation
import SwiftUI

struct MapScreenModalView: View {
    
    var mapScreenViewModel: MapScreenViewModel
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var isOpen: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("titulo")
            Text("Descripcion")
            
            if (isOpen == true) {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.green)
            } else {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.red)
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
    }
}
