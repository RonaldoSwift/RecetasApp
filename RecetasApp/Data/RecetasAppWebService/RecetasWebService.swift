//
//  RecetasWebService.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation
import Combine

class RecetasWebService {
    
    func getReceta(nombreDeReceta:String) -> AnyPublisher<RecetaResponse,Error> {
        guard let urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=faea268df94a44d4b75e8a46ee06f2fc&query=\(nombreDeReceta)") else {
            return Fail(error: RecetasAppError.errorURL)
                .eraseToAnyPublisher()
        }
        
        guard let validUrl = urlComponents.url else {
            return Fail(error: RecetasAppError.urlInvalido)
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(
            url: validUrl
        )
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw RecetasAppError.errorDesconocido
                }
                // 202 - Cuando la aplicacion es exitoso
                if (200 ... 299 ~= httpResponse.statusCode) {
                    return data
                }
                
                //404 - cualquier rango qeu supere al 200 y 299 en el servicio pasa automaticamente al errorResponse
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                throw RecetasAppError.errorData(errorResponse.message)
            }
            .decode(type: RecetaResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    enum RecetasAppError: Error, Equatable {
        case errorURL
        case urlInvalido
        case errorData(String)
        case errorDesconocido
    }
}
