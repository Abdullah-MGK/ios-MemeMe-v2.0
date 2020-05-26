//
//  MemeViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {

    @IBOutlet weak var memedImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memedImageView.image = meme.memedImg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
