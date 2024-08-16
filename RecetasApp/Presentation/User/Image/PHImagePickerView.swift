//
//  PHImagePickerView.swift
//  RecetasApp
//
//  Created by Ronaldo Andre on 15/08/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct PHImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 20
        config.preferredAssetRepresentationMode = .current
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: PHPickerViewController, context _: Context) {
        // We'll not update anything on this view.
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PHImagePickerView
        
        init(parent: PHImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { (image: NSItemProviderReading?, _: Error?) in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
