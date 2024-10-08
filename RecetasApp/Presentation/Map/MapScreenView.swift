import SwiftUI
import MapKit

struct MapScreenView: View {
    
    @StateObject private var mapScreenViewModel = MapScreenViewModel(
        detalleRestauranteRepository: RestauranteRepository(
            recetasWebService: RecetasWebService()
        )
    )
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Coordenadas aproximadas del centro de América del Norte
        span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07) // Ajuste del zoom para cubrir América del Norte
    )
    
    @EnvironmentObject private var sharedMapaViewModel : SharedMapaViewModel
    @State private var restaurantesArray : [Restaurante] = []
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var showModal: Bool = false
    @State private var showModalUser: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                Map(coordinateRegion: $region, annotationItems: restaurantesArray) { restaurante in
                    MapAnnotation(coordinate: restaurante.coordenadas) {
                        Button {
                            sharedMapaViewModel.restaurante = restaurante
                            showModal = true
                        } label: {
                            VStack {
                                Image(ImageResource.mapRestaurant)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                Text(restaurante.name)
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
            if showLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
        .toolbar(content: {
            TextUserToolbarContent(tituloDePantalla: "Mapa", onClick: {
                showModalUser = true
            })
        })
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(mensajeDeAlerta),
                dismissButton: .default(
                    Text("Aceptar"),
                    action: {
                    }
                )
            )
        }
        .onReceive(mapScreenViewModel.$mapScreenUiState, perform: { mapaScreenUiState in
            switch(mapaScreenUiState) {
            case .inicial:
                break
            case .cargando:
                showLoading = true
            case .error(let error):
                showAlert = true
                showLoading = false
                mensajeDeAlerta = error
            case .success(let restaurantes):
                restaurantesArray = restaurantes
                showLoading = false
            }
        })
        .sheet(isPresented: $showModal) {
            MapScreenModalView(onClickBackMap: {
                showModal = false
            })
        }
        .sheet(isPresented: $showModalUser, content: {
            UserScreenModalView(onClickBack: {
                showModalUser = false
            }, onClickSave: {
                showModalUser = false
            })
        })
    }
}

#Preview {
    MapScreenView()
}
