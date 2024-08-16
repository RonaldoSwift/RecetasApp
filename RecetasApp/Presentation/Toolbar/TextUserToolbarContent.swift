//
//  TextToolbarContent.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation
import SwiftUI

struct TextUserToolbarContent: ToolbarContent {
    
    @Environment(\.presentationMode) var presentationMode
    var tituloDePantalla: String
    var onClick: () -> Void
    @EnvironmentObject private var sharedRecetaViewModel : SharedRecetaViewModel
    @State private var imageSwiftUi: Image = Image(systemName: "person.crop.square.badge.camera.fill")
    
    
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
                imageSwiftUi
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.colorMorado)
                    .background(Color.black)
                    .cornerRadius(20)
            })
            .onReceive(sharedRecetaViewModel.$publicadorUIImage) { uiImageNuleable in
                guard let noNullUIImage = uiImageNuleable else {return}
                imageSwiftUi = Image(uiImage: noNullUIImage)
            }
        }
    }
}
