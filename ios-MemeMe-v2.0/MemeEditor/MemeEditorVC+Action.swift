//
//  MemeEditorVC+Action.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/26/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

extension MemeEditorVC {
    
    @IBAction func shareTapped(_ sender: Any) {
        
        // checks if one of texts fields is empty & shows an alert if so
        if topTF.text == "" || bottomTF.text == "" {
            
            // define alert
            let controller = UIAlertController(title: "No Text", message: "Are you sure you want to share without having text written?", preferredStyle: .actionSheet)
            
            // define discard action
            let shareAction = UIAlertAction(title: "Share Anyway", style: .destructive) { action in
                self.share()
            }
            
            // define cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { action in
            }
            
            // add actions to the alert
            controller.addAction(cancelAction)
            controller.addAction(shareAction)
            
            // present alert
            present(controller, animated: true, completion: nil)
            
        } else {
            share()
        }
    }
    
    func share() {
        
        // creates the meme UIImage
        let memeImg = generateMemedImg()
        
        // shows activity view controller
        let controller = UIActivityViewController(activityItems: [memeImg], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in if success {
                
                // adds the image to the datasource after success sharing
                self.save(memeImg)
                
                // updates views when dismissing this viewcontroller after success sharing
                self.delegate?.updateView()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    func save(_ memedImg: UIImage) {
        
        // creates the meme
        let meme = Meme(topTxt: topTF.text!, bottomTxt: bottomTF.text!, originalImg: memeImgView.image!, memedImg: memedImg)
        
        // adds the meme to the memes list
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImg() -> UIImage {
        
        // checks if textfields are empty and if so, make the placeholder empty so that it doesn't show on the image
        topTF.text == "" ? topTF.placeholder = "" : nil
        bottomTF.text == "" ? bottomTF.placeholder = "" : nil
        
        // renders view to an image
        // creates image container as new image with the same size as memeImgView.bounds.size
        UIGraphicsBeginImageContext(memeImgView.bounds.size)
        
        // creates bounds for the area that will be snapshotted
        let bounds = CGRect(x: -memeImgView.frame.minX, y: -memeImgView.frame.minY, width: view.frame.size.width, height: view.frame.size.height)
        
        view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        // creates a UIImage object from what has been drawn into the graphics context
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // cleans image context
        UIGraphicsEndImageContext()
        
        // checks if textfields are empty and if so, reset placeholders
        topTF.text == "" ? topTF.placeholder = "TOP" : nil
        bottomTF.text == "" ? bottomTF.placeholder = "BOTTOM" : nil
        
        return memedImage
    }
    
}
