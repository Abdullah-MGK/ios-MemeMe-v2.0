//
//  MemesCollectionVC.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var memesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        memesCollectionView.delegate = self
        memesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseId = "simpleItem"
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: IndexPath())
        
        return item
    }
    
}
