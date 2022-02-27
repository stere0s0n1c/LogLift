//
//  ImagePicker.swift
//  LogLift
//
//  Created by Гамлет on 24.02.22.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    static func getCorrectPhoto(data: Data) -> UIImage {
        guard let decodedImage: UIImage = UIImage(data: data) else { return UIImage() }
        return decodedImage
    }
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var imageData: Data
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if let data = image.pngData() {
                    parent.imageData = data
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
