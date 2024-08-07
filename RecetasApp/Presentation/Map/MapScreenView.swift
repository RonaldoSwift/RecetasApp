//
//  MapScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import SwiftUI

struct MapScreenView: View {
    
    var body: some View {
        VStack {
            Text("Map")
        }
        .toolbar(content: {
            TextToolbarContent(tituloDePantalla: "Mapa")
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MapScreenView()
}
