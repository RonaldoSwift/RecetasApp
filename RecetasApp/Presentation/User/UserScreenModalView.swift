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
    @State private var shouldPresentImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var inputUIImage: UIImage?
    
    @State private var image: Image = Image(systemName: "person.crop.square.badge.camera.fill")
    @State private var showAlert: Bool = false
    @State private var showLoading: Bool = false
    @State private var mensajeDeAlerta: String = ""
    @State private var isOpen: Bool = false
    @State private var irACamara: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Spacer()
                Button(action: {}, label: {
                    Text("Guardar")
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.colorMorado)
                        .cornerRadius(10)
                })
            }
            
            Spacer()
            
            image
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
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancelar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.colorMorado)
                    .cornerRadius(30)
            })
        }
        .padding()
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
            image = Image(uiImage: noNullInputUIImage)
        }
        .sheet(isPresented: $irACamara, content: {
            AccessCameraView(selectedImage: $inputUIImage)
        })
        .actionSheet(isPresented: $shouldPresentActionScheet, content: { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"),
                        message: Text("Please choose your prefeage"),
                        buttons: [
                            ActionSheet.Button.default(Text("Camera"), action: {
                                cameraManager.requestPermission()
                                userClickOnCamera = true
                                
                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.shouldPresentImagePicker = true
                                
                            }), ActionSheet.Button.cancel()])
            
        })
        .onReceive(cameraManager.$permissionGranted, perform: { permisoAceptado in
            if permisoAceptado {
                irACamara = true
            }
        })
    }
}

