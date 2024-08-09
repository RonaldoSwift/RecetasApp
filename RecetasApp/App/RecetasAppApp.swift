//
//  RecetasAppApp.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 3/08/24.
//

import SwiftUI

@main
struct RecetasAppApp: App {
    
    @StateObject private var appRootManager = AppRootManager()
    var sharedRecetaViewModel = SharedRecetaViewModel()
    
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
                switch appRootManager.currentRoot {
                case .principal:
                    PrincipalRootView()
                        .environmentObject(sharedRecetaViewModel)
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
