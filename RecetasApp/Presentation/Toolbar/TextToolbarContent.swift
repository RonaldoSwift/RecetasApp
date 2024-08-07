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
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrowshape.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(20)
            }
        }
        ToolbarItem(placement: .principal) {
            Text(tituloDePantalla)
        }
    }
}
