//
//  ErrorResponse.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: String
    let message: String
}
