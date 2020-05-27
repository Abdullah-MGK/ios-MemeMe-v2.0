//
//  MemeViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

    let memeEditorId = "MemeEditorVC"
    let memeEditorNavigationId = "MemeEditorNavigationController"
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memedImageView.image = meme.memedImg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
    }
    
    @objc func editTapped() {
        
        //let memeEditorController = storyboard!.instantiateViewController(withIdentifier: memeEditorId) as! MemeEditorVC
        
        // let memeEditorNavigationController = UINavigationController(rootViewController: memeEditorController)
        
        let memeEditorNavigationController = storyboard!.instantiateViewController(withIdentifier: memeEditorNavigationId) as! UINavigationController

        let memeEditorController = memeEditorNavigationController.topViewController as! MemeEditorVC
        
        memeEditorController.meme = meme
        
        present(memeEditorNavigationController, animated: true, completion: nil)
        
    }

}
