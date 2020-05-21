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
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        item.nameLabel!.text = meme.topTxt
        item.imageView!.image = meme.memedImg
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: "VillainDetailSB") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
            navigationController?.pushViewController(detailController, animated: true)
        
    }
    
}
