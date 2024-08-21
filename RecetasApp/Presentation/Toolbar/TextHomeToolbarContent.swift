//
//  TextHomeToolbarContent.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 21/08/24.
//

import Foundation
import SwiftUI

struct TextHomeToolbarContent: ToolbarContent {
    
    var tituloDePantalla: String
    var onClick: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(tituloDePantalla)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                onClick()
            }, label: {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            })
        }
    }
}
