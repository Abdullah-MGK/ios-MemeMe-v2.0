//
//  ViewController+ImagePicker.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/17/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

extension MemeEditorVC {
    
    func setImgPicker(_ sourceType: UIImagePickerController.SourceType) {
        
        // define imagePicker
        let imagePicker = UIImagePickerController()
        
        // assign delegate
        imagePicker.delegate = self
        
        // decide source based on the button
        imagePicker.sourceType = sourceType
        
        // allows cropping
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // the user picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // sets the image view to the selected image dependeing on if the image is cropped (edited)
        if let image = info[.editedImage] as? UIImage {
            memeImgView.image = image
        }
        else if let image = info[.originalImage] as? UIImage {
            memeImgView.image = image
        }
        
        shareBTN.isEnabled = true
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // the user has cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
