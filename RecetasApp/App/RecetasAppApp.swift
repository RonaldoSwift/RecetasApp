//
//  RecetasAppApp.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 3/08/24.
//

import SwiftUI

@main
struct RecetasAppApp: App {
    
    var sharedRecetaViewModel = SharedRecetaViewModel()
    var sharedMapaViewModel = SharedMapaViewModel()
    
    init() {
        let navBarAppearence = UINavigationBarAppearance() // use as global variable, otherwise SwiftUI may cause problems.
        navBarAppearence.configureWithTransparentBackground()
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                PrincipalRootView()
                    .environmentObject(sharedRecetaViewModel)
                    .environmentObject(sharedMapaViewModel)
            }
        }
    }
}
