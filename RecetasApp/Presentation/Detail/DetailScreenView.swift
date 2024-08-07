//
//  DetailScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import SwiftUI

struct DetailScreenView: View {
    
    @State private var irAMap: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                irAMap = true
            } label: {
                Text("Map")
            }
        }
        .toolbar(content: {
            TextToolbarContent()
        })
        .navigation(MapScreenView(), $irAMap)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailScreenView()
}
