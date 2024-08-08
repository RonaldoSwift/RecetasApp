//
//  RecetaCard.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct RecetaCard: View {
    
    var clickEnLaTarjeta: () -> Void
    var urlImage: String
    var nombreDeComida: String
    
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .mask(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
                
                VStack(alignment: .leading){
                    KFImage(URL(string: urlImage)!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .clipShape(RoundedCorner(radius: 12, corners: [.topRight, .topLeft]))
                        .clipped()
                    Spacer()
                    Text(nombreDeComida)
                        .foregroundColor(Color.black)
                        .font(.system(size: 20, weight: .bold))
                        .lineLimit(nil)
                        .allowsTightening(false)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
            .frame(width: 380, height: 200)
            .onTapGesture {
                clickEnLaTarjeta()
            }
    }
}
