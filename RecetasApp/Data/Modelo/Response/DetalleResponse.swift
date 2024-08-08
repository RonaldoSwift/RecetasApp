//
//  DetalleResponse.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 7/08/24.
//

import Foundation

struct DetalleResponse: Decodable {
    
    var readyInMinutes: Int?
    var cookingMinutes: Int?
    var preparationMinutes: Int?
    var summary: String
    
    private enum CodingKeys: String, CodingKey {
        case readyInMinutes
        case cookingMinutes
        case preparationMinutes
        case summary
    }
}
