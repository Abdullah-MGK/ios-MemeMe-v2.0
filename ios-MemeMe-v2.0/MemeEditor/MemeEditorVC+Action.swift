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
        let memeImg = generateMemedImg()
        let controller = UIActivityViewController(activityItems: [memeImg], applicationActivities: nil)
                
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in if success {
                self.save(memeImg)
                
                // Update tableview when dismissing this viewcontroller after share
                self.delegate?.updateView()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    func save(_ memedImg: UIImage) {
        
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
