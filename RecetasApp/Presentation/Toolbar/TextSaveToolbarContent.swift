//
//  TextUserToolbarContent.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 16/08/24.
//

import Foundation
import SwiftUI

struct TextSaveToolbarContent: ToolbarContent {
    
    var tituloDePantalla: String
    var imagenDePantalla: String
    var onClick: () -> Void
    var onClickBack: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                onClickBack()
            } label: {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .foregroundColor(Color.black)
                    .background(Color.colorBack)
                    .cornerRadius(20)
            }
        }
        
        ToolbarItem(placement: .principal) {
            Text(tituloDePantalla)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                onClick()
            }, label: {
                Text("Save")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.colorMorado)
                    .cornerRadius(10)
                
            })
        }
    }
}
