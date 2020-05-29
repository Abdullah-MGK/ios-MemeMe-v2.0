//
//  MemeCollectionViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController, MemeEditorDelegate {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let memeItemId = "MemeItem"
    let memeDetailId = "MemeDetailVC"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Style the collection
        /*
         @IBOutlet weak var memesCollectionViewFlowLayout: UICollectionViewFlowLayout!
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
         */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: memeItemId, for: indexPath) as! MemeCollectionViewCell
            
        let meme = memes[indexPath.row]
        item.imageView!.image = meme.memedImg
    
        return item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assign self as delgate for MemeEditorVC in order to update the tableView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
        
    }
    
    func updateView() {
        collectionView.reloadData()
    }

}

