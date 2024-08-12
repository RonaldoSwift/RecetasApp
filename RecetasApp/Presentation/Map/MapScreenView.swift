//
//  MapScreenView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 6/08/24.
//

import SwiftUI
import MapKit

struct MapScreenView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    let marcadores = [RestauranteMarcador(coordenadas: CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428), titulo: "Gusto"),
                      RestauranteMarcador(coordenadas: CLLocationCoordinate2D(latitude: -12.0480, longitude: -77.0480), titulo: "Dulce")
    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: marcadores) { marcador in
                MapAnnotation(coordinate: marcador.coordenadas) {
                    Button {
                        print("Mapa")
                    } label: {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            Text(marcador.titulo)
                                .font(.caption)
                                .background(Color.white)
                        }
                    }
                }
            }
        }
        .toolbar(content: {
            TextToolbarContent(tituloDePantalla: "Mapa")
        })
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    MapScreenView()
}
