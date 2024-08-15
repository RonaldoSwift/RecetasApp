//
//  CameraManager.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 14/08/24.
//

import Foundation
import AVFoundation

class CameraManager: ObservableObject {
    @Published var permissionGranted = false

    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                self.permissionGranted = accessGranted
            }
        }
    }
}
