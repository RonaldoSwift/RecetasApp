//
//  RestauranteMarcador.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 10/08/24.
//

import Foundation
import MapKit

struct RestauranteMarcador: Identifiable {
    
    let id = UUID()
    let coordenadas : CLLocationCoordinate2D
    let titulo : String
    
}
