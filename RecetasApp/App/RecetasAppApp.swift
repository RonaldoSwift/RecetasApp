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
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .principal:
                    PrincipalRootView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
