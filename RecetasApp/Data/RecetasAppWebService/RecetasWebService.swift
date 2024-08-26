//
//  RecetasWebService.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 5/08/24.
//

import Foundation
import Combine

class RecetasWebService {

    // TODO: FALTA ENVIAR API_KEY POR CABECERA
    
    func getReceta(nombreDeReceta:String) -> AnyPublisher<RecetaResponse,Error> {
        let server_url = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
        let api_key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        
        guard let urlComponents = URLComponents(string: "\(server_url)/recipes/complexSearch?apiKey=\(api_key)&query=\(nombreDeReceta)") else {
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
    
    func getDetalleReceta(id: Int) -> AnyPublisher<DetalleResponse,Error> {
        let server_url = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
        let api_key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        
        guard let urlComponents = URLComponents(string: "\(server_url)/recipes/\(id)/information?apiKey=\(api_key)") else {
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
            .decode(type: DetalleResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getRestaurantes() -> AnyPublisher<RestauranteSearchResponse ,Error> {
        let server_url = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
        let api_key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
        
        guard let urlComponents = URLComponents(string: "\(server_url)/food/restaurants/search") else {
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
            .decode(type: RestauranteSearchResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    enum RecetasAppError: Error, Equatable {
        case errorURL
        case urlInvalido
        case errorData(String)
        case errorDesconocido
    }
}
