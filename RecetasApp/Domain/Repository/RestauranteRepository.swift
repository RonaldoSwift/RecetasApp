//
//  RestauranteRepository.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 12/08/24.
//

import Foundation
import Combine
import MapKit

class RestauranteRepository {
    
    private let recetasWebService: RecetasWebService
    
    var cancelLables = Set<AnyCancellable>()
    
    init(recetasWebService: RecetasWebService) {
        self.recetasWebService = recetasWebService
    }
    
    func getRestaurantesFromWebService() -> AnyPublisher<[Restaurante],Error> {
        return recetasWebService.getRestaurantes().map { (detalleRestauranteResponse:RestauranteSearchResponse) in
            detalleRestauranteResponse.restaurantsResponse.map { (restaurantResponse:RestaurantResponse) in
                Restaurante(
                    id: restaurantResponse.id,
                    name: restaurantResponse.name,
                    description: restaurantResponse.description,
                    phoneNumber: restaurantResponse.phoneNumber,
                    deliveryEnabled: restaurantResponse.deliveryEnabled,
                    type: restaurantResponse.type,
                    isOpen: restaurantResponse.isOpen,
                    coordenadas: CLLocationCoordinate2D(
                        latitude: restaurantResponse.address.latitude,
                        longitude: restaurantResponse.address.longitude
                    )
                )
            }
        }
        .eraseToAnyPublisher()
    }
}
