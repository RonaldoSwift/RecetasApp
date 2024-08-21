//
//  FavoritoScreenModalView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 21/08/24.
//

import Foundation
import SwiftUI

struct FavoritoScreenModalView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                /*List(items, id: \.self) { item in
                    Text(item)
                }*/
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Favorito")
                }
            }
        }
    }
}
