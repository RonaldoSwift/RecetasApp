//
//  RecetaResponse.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation

struct RecetaResponse: Decodable {
    
    var results: [ResultDataResponse]
    var offset: Int
    var number: Int
    var totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case offset
        case number
        case totalResults
    }
}

struct ResultDataResponse: Decodable {
    
    var id: Int
    var title: String
    var image: String
    var imageType: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        case imageType
    }
}
