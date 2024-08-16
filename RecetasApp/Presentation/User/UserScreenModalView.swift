//
//  UserScreenModalView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 14/08/24.
//

import Foundation
import SwiftUI

struct UserScreenModalView: View {
    
    @StateObject var cameraManager = CameraManager()
    @State private var shouldPresentActionScheet = false
    @State private var userClickOnCamera = false
    @State private var presentarSelectorDeImagen = false
    
    @EnvironmentObject private var sharedRecetaViewModel : SharedRecetaViewModel

    var onClickBack : () -> Void
    var onClickSave : () -> Void
    
    @State private var inputUIImage: UIImage?
    @State private var imageSwiftUI: Image = Image(systemName: "person.crop.square.badge.camera.fill")
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var isOpen: Bool = false
    @State private var irACamara: Bool = false
    @State private var saveImage: Bool = false
    @State private var isPresent = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Spacer()
                imageSwiftUI
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .foregroundColor(Color.colorMorado)
                    .overlay(Circle().stroke(Color.yellow, lineWidth: 4))
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        shouldPresentActionScheet = true
                    }
                
                Spacer()
                
                HStack {
                    VStack(spacing: 30) {
                        Text("Nombre: Juan")
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(nil)
                            .allowsTightening(false)
                            .multilineTextAlignment(.center)
                        
                        Text("Edad: 42 años")
                            .font(.system(size: 20, weight: .bold))
                            .lineLimit(nil)
                            .allowsTightening(false)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                Spacer()
                
            }
            .padding()
            .toolbar(content: {
                TextSaveToolbarContent(
                    tituloDePantalla: "User",
                    imagenDePantalla: "",
                    onClick: {
                        guard let noNullInputUIImage = inputUIImage else {return}
                        sharedRecetaViewModel.publicadorUIImage = noNullInputUIImage
                        onClickSave()
                    },
                    onClickBack: {
                        onClickBack()
                    }
                )
            })
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
            .onChange(of: inputUIImage) { _ in
                guard let noNullInputUIImage = inputUIImage else {return}
                imageSwiftUI = Image(uiImage: noNullInputUIImage)

            }
            .sheet(isPresented: $irACamara) {
                AccessCameraView(selectedImage: $inputUIImage)
            }
            .sheet(isPresented: $presentarSelectorDeImagen, onDismiss: {}) {
                PHImagePickerView(image: $inputUIImage)
            }
            .actionSheet(isPresented: $shouldPresentActionScheet, content: { () -> ActionSheet in
                ActionSheet(title: Text("Choose mode"),
                            message: Text("Please choose your prefeage"),
                            buttons: [
                                ActionSheet.Button.default(Text("Camera"), action: {
                                    cameraManager.requestPermission()
                                    userClickOnCamera = true
                                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                    self.presentarSelectorDeImagen = true
                                }), ActionSheet.Button.cancel()])
            })
            .onReceive(cameraManager.$permissionGranted, perform: { permisoAceptado in
                if permisoAceptado {
                    irACamara = true
                }
            })
        }
    }
}
