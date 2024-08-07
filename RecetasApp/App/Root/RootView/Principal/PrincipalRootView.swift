//
//  PrincipalRootView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation
import SwiftUI

// TODO: Mejorar esta navegacion entre pantallas
struct PrincipalRootView: View {
    
    @State private var isActiveDetailScreen: Bool = false
    
    var body: some View {
        NavigationView {
            HomeScreenView(onClickInDetail: {
                isActiveDetailScreen = true
            })
            .navigation(DetailScreenView(), $isActiveDetailScreen)
        }
    }
}
