//
//  DetalleRestauranteResponse.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation

struct RestauranteSearchResponse: Decodable {
    
    var restaurantsResponse: [RestaurantResponse]
    
    private enum CodingKeys: String, CodingKey {
        case restaurantsResponse = "restaurants"
    }
}

struct RestaurantResponse: Decodable {
    
    var id: String
    var name: String
    var description: String
    var phoneNumber: Int?
    var address: AddressResponse
    var deliveryEnabled: Bool
    var type: String?
    var isOpen: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case phoneNumber = "phone_number"
        case address
        case deliveryEnabled = "delivery_enabled"
        case type
        case isOpen = "is_open"
    }
}

struct AddressResponse: Decodable {
    var latitude : Double
    var longitude: Double
}





