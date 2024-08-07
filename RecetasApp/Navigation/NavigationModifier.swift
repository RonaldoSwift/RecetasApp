//
//  NavigationModifier.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation
import SwiftUI

struct NavigationModifier: ViewModifier {
    var destinationView: AnyView
    @Binding var isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    destination: destinationView,
                    isActive: $isActive
                ) {
                    EmptyView()
                }
            )
    }
}
