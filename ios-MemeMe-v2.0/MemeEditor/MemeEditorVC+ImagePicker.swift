//
//  ViewController+ImagePicker.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/17/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorVC {
    
    func setImgPicker(_ sourceType: UIImagePickerController.SourceType) {
        
        // define imagePicker
        let imagePicker = UIImagePickerController()
        
        // assign delegate
        imagePicker.delegate = self
        
        // decide source based on the button
        imagePicker.sourceType = sourceType
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    // the user picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // sets the image view to the selected image
        if let image = info[.originalImage] as? UIImage {
            memeImgView.image = image
            dismiss(animated: true, completion: nil)
        }
        
        shareBTN.isEnabled = true
        
    }
    
    // the user has cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        let memeImg = generateMemedImg()
        let controller = UIActivityViewController(activityItems: [memeImg], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in if success {
                self.save()
            }
        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    func save() {
        
        // generate the memed image
        let memedImg = generateMemedImg()
        
        // Create the meme
        let meme = Meme(topTxt: topTF.text!, bottomTxt: bottomTF.text!, originalImg: memeImgView.image!, memedImg: memedImg)
        
        // Add the meme to the memes list
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
    }
    
    func generateMemedImg() -> UIImage {
        
        // Hide toolbar and navbar
        // toggleBars(hidden: true)
        
        // Render view to an image
        // bounds wrt view object, frame wrt super view (screen)
        // Creates image container: creates a new image with the same size as memeImgView.bounds.size
        UIGraphicsBeginImageContext(memeImgView.bounds.size)
        
        // create bounds for the area that will be snapshotted
        let bounds = CGRect(x: -memeImgView.frame.minX, y: -memeImgView.frame.minY, width: view.frame.size.width, height: view.frame.size.height)
        
        // 'view.' takes the view with its children (not only the meme image view)
        // 'in self.memeImgView.bounds' takes whole screen and squish in the container
        // 'in self.view.bounds' takes the whole screen and crop it in the container
        // using the defined bounds will solve that issue
        view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        // Creates an UIImage object from what has been drawn into the graphics context
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        // Cleans image context
        UIGraphicsEndImageContext()
        
        // or this
        // let renderer = UIGraphicsImageRenderer(size: memeImgView.bounds.size)
        // let memedImage = renderer.image { ctx in
        // view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        // }
        
        // Show toolbar and navbar
        // toggleBars(hidden: false)
        
        return memedImage
        
    }
    
    // func toggleBars(hidden: Bool) { }
    
}