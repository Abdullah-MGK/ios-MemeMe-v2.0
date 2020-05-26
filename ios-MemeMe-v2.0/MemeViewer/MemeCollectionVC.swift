//
//  MemeCollectionViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let reuseIdentifier = "MemeItem"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
            
        let meme = memes[indexPath.row]
        item.imageView!.image = meme.memedImg
    
        return item
    }

}

/*
 class MemesCollectionVC2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
     
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
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
         let detailController = storyboard!.instantiateViewController(withIdentifier: "VillainDetailSB") as! MemeDetailViewController
         detailController.meme = memes[indexPath.row]
             navigationController?.pushViewController(detailController, animated: true)
         
     }
     
 }

 */
