//
//  ViewController+ImagePicker.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/17/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

extension MemeEditorVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func pickImgTapped(_ sender: UIBarButtonItem) {
        
        // presents image picker based on the button clicked
        switch(ButtonType(rawValue: sender.tag)!) {
        case .camera : setImgPicker(.camera)
        case .album : setImgPicker(.photoLibrary)
        }
    }
    
    func setImgPicker(_ sourceType: UIImagePickerController.SourceType) {
        
        // defines imagePicker
        let imagePicker = UIImagePickerController()
        
        // assigns self as a delegate
        imagePicker.delegate = self
        
        // decides source based on the button
        imagePicker.sourceType = sourceType
        
        // allows cropping
        imagePicker.allowsEditing = true
        
        // presents image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
