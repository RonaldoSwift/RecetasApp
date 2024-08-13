//
//  DetalleRestaurante.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation
import MapKit

struct Restaurante: Identifiable {
    var id : String
    var name: String
    var description: String
    var phoneNumber: Int?
    var deliveryEnabled: Bool
    var type: String?
    var isOpen: Bool
    var coordenadas : CLLocationCoordinate2D
}
