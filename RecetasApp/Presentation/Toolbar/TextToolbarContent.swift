//
//  TextToolbarContent.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation
import SwiftUI

struct TextToolbarContent: ToolbarContent {
    
    @Environment(\.presentationMode) var presentationMode
    var tituloDePantalla: String
    var onClick: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                presentationMode.wrappedValue.dismiss()
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
                Image(systemName: "person.crop.square.badge.camera.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.colorMorado)
                    .background(Color.black)
                    .cornerRadius(20)
            })
        }
    }
}
