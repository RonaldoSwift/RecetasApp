//
//  AccessCameraView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 14/08/24.
//

import Foundation
import SwiftUI

struct AccessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) {
        // We'll not update anything on this view.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    // Coordinator will help to preview the selected image in the View.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: AccessCameraView

        init(parent: AccessCameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            parent.selectedImage = selectedImage
            picker.dismiss(animated: true)
        }
    }
}
