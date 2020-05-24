//
//  MemesCollectionVC.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemesCollectionVC2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var memesCollectionView: UICollectionView!
    @IBOutlet weak var memesCollectionViewFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        memesCollectionView.delegate = self
        memesCollectionView.dataSource = self
        
        // can be accessed via storyboard
        let space: CGFloat = 3.0
        let dimension: CGFloat = (view.frame.size.width - (2 * space)) / 3.0
        let dimension2: CGFloat = ( view.frame.size.height - (2 * space) ) / 3.0
        
        // governs the space between items within a row or column (margin)
        memesCollectionViewFlowLayout.minimumInteritemSpacing = space
        
        // governs the space between rows or columns (padding)
        memesCollectionViewFlowLayout.minimumLineSpacing = space
        
        // governs cell size
        memesCollectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseId = "memeItem"
        
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
