//
//  MemeViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController, MemeEditorDelegate {
    
    // identifiers
    let memeEditorId = "MemeEditorVC"
    let memeEditorNavigationId = "MemeEditorNavigationController"
    
    // IBoutlets
    @IBOutlet weak var memedImageView: UIImageView!
    
    // current meme
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assigns the passed image to ImageView
        memedImageView.image = meme.memedImg
        
        // adds edit buttom to the navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
    }
    
    @objc func editTapped() {
        
        // shows memeEditorController for the meme
        let memeEditorNavigationController = storyboard!.instantiateViewController(withIdentifier: memeEditorNavigationId) as! UINavigationController

        let memeEditorController = memeEditorNavigationController.topViewController as! MemeEditorVC
        
        memeEditorController.meme = meme
        
        // assigns self as delgate for MemeEditorVC in order to get to its root
        memeEditorController.delegate = self
        
        present(memeEditorNavigationController, animated: true, completion: nil)
    }
    
    func updateView() {
        navigationController?.popToRootViewController(animated: true)
    }

}
