//
//  AppRootManager.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import Foundation

final class AppRootManager: ObservableObject {
    @Published var currentRoot: AppRoots = .principal
    
    enum AppRoots {
        case principal
    }
}
