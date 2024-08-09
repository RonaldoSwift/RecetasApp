//
//  DetalleCard.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 8/08/24.
//

import Foundation
import SwiftUI

struct DetalleCard: View {
    
    var tituloDeReceta: String
    var tiempo: Int
    var calorias: Int
    var personas: Int
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .mask(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            VStack{
                Text(tituloDeReceta)
                    .foregroundColor(Color.black)
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(nil)
                    .allowsTightening(false)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom,10)
                HStack(spacing: 20) {
                    
                    propiedades(
                        imagenIcono: "clock",
                        textoDeServicio: tiempo,
                        textoFijo: "min"
                    )
                    
                    propiedades(
                        imagenIcono: "flame.fill",
                        textoDeServicio: calorias,
                        textoFijo: "cals"
                    )
                    
                    propiedades(
                        imagenIcono: "figure",
                        textoDeServicio: personas,
                        textoFijo: "min"
                    )
                }
            }
        }
        .frame(width: 330, height: 130)
    }
    
    func propiedades(imagenIcono: String, textoDeServicio: Int, textoFijo: String) -> some View {
        HStack {
            Image(systemName: imagenIcono)
            Text("\(textoDeServicio)")
            Text(textoFijo)
        }
    }
}
